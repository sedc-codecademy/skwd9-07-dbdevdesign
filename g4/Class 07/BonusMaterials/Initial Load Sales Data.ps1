#2021-03-02 Petr Loffelmann CTGR-11 
#Import initial sales data csv and process it using standard VAIS mechanism

# Script outline: 
# ---------------
 # Create "temp" table, which will hold the data, column names are based on csv headers
 # Use BULK IMPORT functionality to populate the table (imported file needs to be accessible from the SQL Server instance)
 # Remove quotes from all columns, replace coma with dot in number columns
 # Copy the data from temp table into respective tables: stage.sales_sales, stage.Sales_TransactionData, stage.Sales_TransactionDateFinancial, stage.Sales_TransactionDateStatistical
 # Drop temp table if user chooses to
 # Commit transaction if everything went well
 # Execute stage.NAISSalesMessage and customized.SalesTransactionDeleteDuplicateRows to processs the data

#Note: for the processing by stage.NAISSalesMessage to work, the filename MUST contain dash and four character code of the country
#e.g.: dynamic_pricing_export_stocktrans-M000_2019_2021.csv 

###############################################################################


if ($args.count -ne 6) {Write-Host "Please supply following parameters (in this order): 
  Name of the file to be imported (absolute path, must be located at the same server as the DB) `r`n  DB server to connect to
  DB to which you want to insert the data `r`n  Name of the table which you want to create and populate (incl. schema) 
  Username which will be used to connect to the DB `r`n  Password which will be used to connect to the DB"
exit
}

$FilePath = $args[0]
$DBServer = $args[1]
$DBName = $args[2]
$TableName = $args[3]
$UserName = $args[4]
$Password = $args[5]


$Header = Get-Content $FilePath -First 1
$HeaderArray = $Header.Split(";") -replace '"', ''
$TransactionCreated = $false


try {
    $SqlConnection = new-object system.data.SqlClient.SQLConnection("Server=$DBServer;Database=$DBName;User Id=$UserName;Password=$Password;")
    $SqlConnection.Open()
    $SqlTransaction = $SqlConnection.BeginTransaction("InitialImport");
    $TransactionCreated = $true


    Write-Host "Creating temp table"
    $SqlQuery = "DROP TABLE IF EXISTS $DBName.$TableName; `r`nCREATE TABLE $DBName.$TableName ( `r`n"
    for ($i = 0; $i -lt $HeaderArray.Length; $i++) {
        $SqlQuery += "[$($HeaderArray[$i])] NVARCHAR(100) NULL"
        if ($i -ne $HeaderArray.Length-1) { 
            $SqlQuery += ", `r`n"
        }
    }
    $SqlQuery += ")"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "Table created successfully"


    Write-Host "Starting data import"
    $SqlQuery = "BULK INSERT $DBName.$TableName
        FROM '"+"$FilePath"+"'
        WITH (DATAFILETYPE = 'char'
          , FIRSTROW = 2
          , BATCHSIZE = 10000
          , FIELDTERMINATOR = ';'
	      , ROWTERMINATOR = '0x0a'
	      );"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "Data imported into temp table successfully"


    Write-Host "Removing double quotes"
    $SqlQuery = "UPDATE $DBName.$TableName SET `r`n"
    for ($i = 0; $i -lt $HeaderArray.Length; $i++) {
        $SqlQuery += "[$($HeaderArray[$i])] = REPLACE([$($HeaderArray[$i])], '"+'"'+"', '')"
        if ($i -ne $HeaderArray.Length-1) { 
            $SqlQuery += ", `r`n"
        }
    }
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "Double quotes removed successfully"

    Write-Host "Replacing , with . in numbers"
    $SqlQuery = "UPDATE $DBName.$TableName SET 
                    $($HeaderArray[9]) = REPLACE($($HeaderArray[9]), ',', '.'), $($HeaderArray[10]) = REPLACE($($HeaderArray[10]), ',', '.'), $($HeaderArray[11]) = REPLACE($($HeaderArray[11]), ',', '.'), 
                    $($HeaderArray[12]) = REPLACE($($HeaderArray[12]), ',', '.'), $($HeaderArray[14])  = REPLACE($($HeaderArray[14]), ',', '.'), $($HeaderArray[15]) = REPLACE($($HeaderArray[15]), ',', '.'), 
                    $($HeaderArray[17]) = REPLACE($($HeaderArray[17]), ',', '.'), $($HeaderArray[18]) = REPLACE($($HeaderArray[18]), ',', '.'), $($HeaderArray[19]) = REPLACE($($HeaderArray[19]), ',', '.')"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "Commas replaced successfully"
    

    Write-Host "Inserting data into $DBName.stage.sales_sales table"
    $FileName = $FilePath.ToString().Split("\\")[$FilePath.ToString().Split("\\").Length-1]
    $SqlQuery = "INSERT INTO $DBName.stage.sales_sales 
                 SELECT NEWID() Identifier, GETDATE() FileCreatedDate, '$FileName' FileName, NULL Status, 9 StageId, 'ASS-001' AssortmentCode, $($HeaderArray[6]) TransactionType, $($HeaderArray[3]) ItemNumber, $($HeaderArray[4]) CustomerCode, $($HeaderArray[5]) SalesBECode, 
                    $($HeaderArray[0]) OrderType, $($HeaderArray[13]) InvoiceNumber, $($HeaderArray[14]) SalesLineNumber, $($HeaderArray[7]) QuoteNumber, $($HeaderArray[9]) Quantity, $($HeaderArray[17]) GrossPriceLocal, $($HeaderArray[15]) GrossPriceTransaction, $($HeaderArray[10]) NetValueTransaction, 
                    $($HeaderArray[18]) NetValueCustomer, $($HeaderArray[19]) LineValue, $($HeaderArray[11]) MarginA, $($HeaderArray[12]) MarginC, $($HeaderArray[21]) InternetVoucher, $($HeaderArray[22]) ActionID, $($HeaderArray[20]) SalesChannelFlag, NEWID() RecordIdentifier, NULL ParentIdentifier
                 FROM $DBName.$TableName"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "OK"

    Write-Host "Inserting data into $DBName.stage.Sales_TransactionData table"
    $FileName = $FilePath.ToString().Split("\\")[$FilePath.ToString().Split("\\").Length-1]
    $SqlQuery = "INSERT INTO $DBName.stage.Sales_TransactionData
                SELECT Identifier, GETDATE() FileCreatedDate, FileName, Status, StageId, YEAR(CONVERT(datetime, $($HeaderArray[1]), 104)) [Year], Month(CONVERT(datetime, $($HeaderArray[1]), 104)) [Month], DAY(CONVERT(datetime, $($HeaderArray[1]), 104)) [Day], RecordIdentifier, ParentIdentifier 
                FROM $DBName.$TableName tmp JOIN $DBName.stage.sales_sales s ON tmp.$($HeaderArray[0]) = s.OrderType AND s.FileName = '$FileName'"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "OK"

    Write-Host "Inserting data into $DBName.stage.Sales_TransactionDateFinancial table"
    $FileName = $FilePath.ToString().Split("\\")[$FilePath.ToString().Split("\\").Length-1]
    $SqlQuery = "INSERT INTO $DBName.stage.Sales_TransactionDateFinancial
                SELECT Identifier, GETDATE() FileCreatedDate, FileName, Status, StageId, YEAR(CONVERT(datetime, $($HeaderArray[16]), 104)) [Year], Month(CONVERT(datetime, $($HeaderArray[16]), 104)) [Month], DAY(CONVERT(datetime, $($HeaderArray[16]), 104)) [Day], RecordIdentifier, ParentIdentifier 
                FROM $DBName.$TableName tmp JOIN $DBName.stage.sales_sales s ON tmp.$($HeaderArray[0]) = s.OrderType AND s.FileName = '$FileName'"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "OK"

    Write-Host "Inserting data into $DBName.stage.Sales_TransactionDateStatistical table"
    $FileName = $FilePath.ToString().Split("\\")[$FilePath.ToString().Split("\\").Length-1]
    $SqlQuery = "INSERT INTO $DBName.stage.Sales_TransactionDateStatistical
                SELECT Identifier, GETDATE() FileCreatedDate, FileName, Status, StageId, YEAR(CONVERT(datetime, $($HeaderArray[2]), 104)) [Year], Month(CONVERT(datetime, $($HeaderArray[2]), 104)) [Month], DAY(CONVERT(datetime, $($HeaderArray[2]), 104)) [Day], RecordIdentifier, ParentIdentifier 
                FROM $DBName.$TableName tmp JOIN $DBName.stage.sales_sales s ON tmp.$($HeaderArray[0]) = s.OrderType AND s.FileName = '$FileName'"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.Transaction = $SqlTransaction
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "OK"    
    Write-Host "`r`nImport was successfull"

    $dropTable = Read-Host -Prompt "Do you want to drop the temp table? [Y/N]"
    if ($dropTable -eq 'Y') {
        Write-Host "Dropping temp table"
        $SqlQuery = "DROP TABLE $DBName.$TableName"    
        $SqlCommand = new-object system.data.sqlclient.sqlcommand($SqlQuery,$SqlConnection)
        $SqlCommand.CommandTimeout = 0
        $SqlCommand.Transaction = $SqlTransaction
        $SqlCommand.ExecuteNonQuery() > $null
        Write-Host "Table $DBName.$TableName dropped"
    }
    else {
        if ($dropTable -eq 'N') {
            Write-Host "N pressed, table not deleted"
        }
        else {
            Write-Host "You pressed something else, table not deleted"
        }
    }
    
    $SqlTransaction.Commit()
    $TransactionCreated = $false
      
    Write-Host "`r`nImported data will be processed now`r`n"

    #following is not part of the transaction anymore
	#note: if there is inner exception in either sp, the script has no way of notifying you, check the tables contain data (e.g. stage.sales_salesHistory)
    Write-Host "Running [stage].[NAISSalesMessage]"
    $SqlCommand = new-object system.data.sqlclient.sqlcommand("EXEC [stage].[NAISSalesMessage]",$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "[stage].[NAISSalesMessage] done"


    Write-Host "Running [customized].[SalesTransactionDeleteDuplicateRows]"    
    $SqlCommand = new-object system.data.sqlclient.sqlcommand("EXEC [customized].[SalesTransactionDeleteDuplicateRows]",$SqlConnection)
    $SqlCommand.CommandTimeout = 0
    $SqlCommand.ExecuteNonQuery() > $null
    Write-Host "[customized].[SalesTransactionDeleteDuplicateRows] done"


    Write-Host "`r`n`r`nAll the data has been processed successfully`r`n"  
}
catch { 
    Write-Host -Foreground Red -Background Black $_.Exception.Message     
    try {
        if ($TransactionCreated) {
            $SqlTransaction.Rollback()
            Write-Host "Transaction rolled back"  
        }
    }
    catch {
        Write-Host -Foreground Red -Background Black $_.Exception.Message  
    }
}
finally {    
    $SqlConnection.Close()