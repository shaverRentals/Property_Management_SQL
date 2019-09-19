CREATE TABLE [dbo].[Properties] (
    [Property_ID]    INT          IDENTITY (1, 1) NOT NULL,
    [Street]         VARCHAR (50) NOT NULL,
    [City]           VARCHAR (50) NOT NULL,
    [State]          VARCHAR (50) NOT NULL,
    [ZIP]            VARCHAR (50) NULL,
    [Owners]         VARCHAR (50) NULL,
    [Number_Units]   INT          NOT NULL,
    [Date_Purchase]  DATE         NOT NULL,
    [Price_Purchase] MONEY        NOT NULL,
    [Seller]         VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED ([Property_ID] ASC)
);

