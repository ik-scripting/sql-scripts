-- Show every Database Size
-- On new vindow
sp_msforeachtable 'EXEC sp_spaceused [?]' GO
exec  sp_spaceused N'sdct_PS_NetStampPreLoad';
