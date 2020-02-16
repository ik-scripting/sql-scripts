-- stored procedure
-- add create user
create or alter procedure [dbo].[sp_createdbuser] (
    @db nvarchar(max),
    @login nvarchar(max),
    @user nvarchar(max),
    @pass nvarchar(max),
    @canCreate bit,
    @canWrite bit,
    @canRead bit
) as begin
    if exists (select * from master.sys.databases where name = @db)
        print 'database ' + @db + ' already exists'
    else exec ('create database ' + @db)

    if exists (select * from master.sys.sql_logins where name = @login)
        print 'login ' + @login + ' already exists'
    else exec('create login ' + @login + ' with password = ''' + @pass + ''', check_policy = OFF')

    exec('use ' + @db + ';'
        + ' if exists(select * from sys.database_principals where name = ''' + @user + ''') print ''user ' + @user + ' already exists'''
        + ' else create user ' + @user + ' for login ' + @login + ' with default_schema = dbo')

    if @canCreate = 1 exec('use ' + @db + '; alter role db_ddladmin add member ' + @user)
    if @canWrite = 1 exec('use ' + @db + '; alter role db_datawriter add member ' + @user)
    if @canRead = 1 exec('use ' + @db + '; alter role db_datareader add member ' + @user)
end
go

-- usage
-- exec createdbuser 'DatabaseName', 'test-login', 'test-user-name', 'test-pass', false, true, true
drop procedure sp_createdbuser

/*
drop login testlogin
*/
