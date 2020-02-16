-- delete users
create or alter procedure [dbo].[sp_dropdbuser] (
    @db nvarchar(max),
    @login nvarchar(max),
    @user nvarchar(max)
) as begin
    if exists (select * from master.sys.databases where name = @db)
        print 'database ' + @db + ' found'

    if exists (select * from master.sys.sql_logins where name = @login)
        print 'login ' + @login + ' login found'
        exec('drop login ' + @login)

    if exists (select * from sys.database_principals where name = @user and type_desc = 'SQL_USER')
        print 'user ' + @user + ' user found'
        exec sp_dropuser @user
end
go
