--
CREATE ROLE [db_execproc] AUTHORIZATION [dbo]
GO
GRANT EXECUTE ON OBJECT ::dbo.sp_NAME TO db_execproc;
GO
