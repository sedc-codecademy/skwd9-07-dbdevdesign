GO
/****** Object:  StoredProcedure [dbo].[faster_db]    Script Date: 6/28/2021 7:46:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   PROCEDURE [dbo].[faster_db]
--	exec [dbo].[faster_db]
AS

DECLARE @SQL NVARCHAR(MAX) = ''

BEGIN




  SELECT  @SQL = isnull(@SQL,'') + st   
  FROM (
    SELECT  
      'ALTER INDEX ['+I.NAME+'] ON ['+OBJECT_SCHEMA_NAME(s.object_id, DB_ID())+'].['+CAST(OBJECT_NAME(S.Object_ID, DB_ID()) AS VARCHAR(50))+
      CASE WHEN avg_fragmentation_in_percent <= 20 
        THEN '] REORGANIZE;'
        ELSE '] REBUILD'+
          CASE WHEN ( 
                     (CHARINDEX('Developer',CAST(SERVERPROPERTY('edition') AS NVARCHAR(200)))>0
                      OR (CHARINDEX('Enterprise',CAST(SERVERPROPERTY('edition') AS NVARCHAR(200)))>0) 
                     )
                    )
            THEN ' WITH (ONLINE = ON, MAXDOP = 1);'+CHAR(10)
            ELSE ';'+CHAR(10)
          END  
      END 
      AS St
      ,ROW_NUMBER() over (partition by i.name order by avg_fragmentation_in_percent desc) r 
      , index_type_desc 
    FROM sys.dm_db_index_physical_stats (DB_ID(),NULL,NULL,NULL,'DETAILED' ) S
      LEFT OUTER JOIN sys.indexes I On (I.Object_ID = S.Object_ID and I.Index_ID = S.Index_ID) AND S.INDEX_ID > 0
    --WHERE 
   --   avg_fragmentation_in_percent >= 10
   --   AND page_count > 20
   --   AND i.NAME NOT LIKE '%aspn%'
	  --AND OBJECT_SCHEMA_NAME(s.object_id, DB_ID()) NOT IN ('Integration','Dimension','Fact')
   --    AND NOT EXISTS (SELECT * FROM sys.columns c 
   --                                   WHERE c.object_id=S.Object_ID 
   --                                     AND (c.system_type_id in (TYPE_ID('text'), type_id('ntext'), type_id('image'), TYPE_ID('xml')) 
   --                                     OR (c.system_type_id IN (type_id('varchar'), type_id('nvarchar'), type_id('varbinary')) and c.max_length < 0) )
                                  --  )    
  ) t
  WHERE t.r = 1
  ORDER BY t.index_type_desc
  print @sql
  EXEC (@SQL)

print '--------------------'
print '---  Statistics  ---'
print '--------------------'

-- update statistics

  BEGIN TRY
    EXEC sp_updatestats
  END TRY
  BEGIN CATCH
    IF ERROR_NUMBER() = 15247
      BEGIN
      	  SELECT  @SQL = isnull(@SQL,'') + st   
		  FROM (
			SELECT 'UPDATE STATISTICS '+'['+schema_name(t.schema_id)+'].['+t.name +']; ' AS st
	        FROM sys.tables t 
	        WHERE SCHEMA_NAME(t.SCHEMA_ID) NOT IN ('history','Integration','Fact','Dimension')
	          AND LEFT(t.name,3) NOT IN ('asp','nai')
	          AND EXISTS (SELECT NULL FROM sys.stats s 
	                      WHERE t.OBJECT_ID = s.OBJECT_ID
                          and STATS_DATE(t.OBJECT_ID, s.stats_id) < DATEADD(d,-7,GETDATE())
                       )
	) t

		   print @sql
	       EXEC (@SQL)
	    END    
  END CATCH

END