﻿CREATE TABLE [dbo].[Version](
	[Version_ID] [int] IDENTITY(1,1) NOT NULL,
	[Number_Version] [varchar](max) NOT NULL,
	[Date_Version] [date] NOT NULL,
	[Desc_Version] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Version] PRIMARY KEY CLUSTERED 
(
	[Version_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
