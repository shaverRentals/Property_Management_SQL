CREATE TABLE [dbo].[Settings]
(
[Site_Settings_ID] [int] IDENTITY(1,1) NOT NULL,
	[Setting] [varchar](100) NOT NULL,
	[Setting_Value] [varchar](max) NULL,
	[Setting_Description] [varchar](max) NULL, 
    CONSTRAINT [PK_Settings] PRIMARY KEY ([Site_Settings_ID])
)