DROP TABLE IF EXISTS [PersonTestTable]
GO
CREATE TABLE [PersonTestTable](
    [FirstName] [varchar](400) NULL,
    [LastName] [varchar](400) NULL,
    [Mail] [varchar](100) NULL,
    Country [varchar](100) NULL,
    Age [int] NULL
    
) ON [PRIMARY]
GO
    
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Lawrence',N'Williams',N'uhynb.ndlguey@vtq.org',N'U.S.A.',21)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Gilbert',N'Miller',N'loiysr.jeoni@wptho.co',N'U.S.A.',53)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Salvador',N'Rodriguez',N'tjybsrvg.rswed@uan.org',N'Russia',46)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Ernest',N'Jones',N'psxkrzf.jgcmc@pfdknl.org',N'U.S.A.',48)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Jerome',N'Garcia',NULL,N'Russia',46)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Roland',N'Smith','xpdek.qpl@kpl.com',N'U.S.A. ',35)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Stella',N'Johnson',N'qllyoxgr.jsntdty@pzwm.org',N'Russia',24)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Aria',N'Anderson',N'sjgnz.voyyc@cvjg.com',N'Brazil ',25)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Edward',N'Martinez','pokjs.oas@mex.com',N'Mexico ',27)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Nicholas',N'Brown',N'wpfiki.hembt@uww.co',N'Russia ',43)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Ray',N'Wilson',NULL,N'Russia',41)
INSERT INTO [dbo].[PersonTestTable]([FirstName],[LastName],[Mail],[Country],[Age]) VALUES (N'Jorge',N'Davis',N'bhlji.zwngl@kle.com',N'Russia ',49)
GO




SELECT FirstName FROM PersonTestTable
---------------------------------------------
SELECT STRING_AGG(FirstName,'-') AS Result FROM PersonTestTable

----------------------
SELECT FirstName FROM [PersonTestTable] ORDER BY FirstName ASC

SELECT STRING_AGG(FirstName,'-')  WITHIN GROUP ( ORDER BY FirstName ASC)  AS Result FROM [PersonTestTable]


SELECT Country,STRING_AGG(Mail,',')  WITHIN GROUP ( ORDER BY FirstName ASC)  AS
Result FROM PersonTestTable
GROUP BY Country
ORDER BY Country asc