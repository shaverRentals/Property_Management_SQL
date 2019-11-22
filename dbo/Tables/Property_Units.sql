CREATE TABLE [dbo].[Property_Units] (
    [Property_Unit_ID]      INT          IDENTITY (1, 1) NOT NULL,
    [Property_ID]           INT          NOT NULL,
    [Unit_Street]           VARCHAR (50) NULL,
    [Unit_Location]         VARCHAR (50) NULL,
    [Share_City]            FLOAT (53)   NULL,
    [Share_Electricity]     FLOAT (53)   NULL,
    [Share_Gas]             FLOAT (53)   NULL,
    [Property_Description] VARCHAR(50) NULL, 
    CONSTRAINT [PK_Property_Units] PRIMARY KEY CLUSTERED ([Property_Unit_ID] ASC),
    CONSTRAINT [FK_Property_Units_Properties] FOREIGN KEY ([Property_ID]) REFERENCES [dbo].[Properties] ([Property_ID])
);

