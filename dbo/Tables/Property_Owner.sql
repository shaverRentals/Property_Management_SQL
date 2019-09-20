CREATE TABLE [dbo].[Property_Owner] (
    [Property_Owner_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Property_Owner_Description] VARCHAR (244) NULL,
    CONSTRAINT [PK_Property_Owner] PRIMARY KEY CLUSTERED ([Property_Owner_ID] ASC)
);

