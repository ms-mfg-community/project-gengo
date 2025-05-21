-- Based on the ERD diagram at source: https://www.devart.com/dbforge/sql/studio/database-diagram.html
-- Create Database Tables SQL script
-- Generated based on ERD diagram for bookstore database

-- Drop existing tables if they exist to avoid conflicts
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sales]') AND type in (N'U'))
    DROP TABLE [dbo].[sales];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[titleauthor]') AND type in (N'U'))
    DROP TABLE [dbo].[titleauthor];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[roysched]') AND type in (N'U'))
    DROP TABLE [dbo].[roysched];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[discounts]') AND type in (N'U'))
    DROP TABLE [dbo].[discounts];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[employee]') AND type in (N'U'))
    DROP TABLE [dbo].[employee];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jobs]') AND type in (N'U'))
    DROP TABLE [dbo].[jobs];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pub_info]') AND type in (N'U'))
    DROP TABLE [dbo].[pub_info];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[titles]') AND type in (N'U'))
    DROP TABLE [dbo].[titles];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stores]') AND type in (N'U'))
    DROP TABLE [dbo].[stores];
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[publishers]') AND type in (N'U'))
    DROP TABLE [dbo].[publishers];

-- Publishers table
CREATE TABLE [dbo].[publishers] (
    [pub_id] [char](4) NOT NULL,
    [pub_name] [varchar](40) NULL,
    [city] [varchar](20) NULL,
    [country] [varchar](30) NULL,
    CONSTRAINT [PK_publishers] PRIMARY KEY CLUSTERED ([pub_id] ASC)
);

-- Publisher Info table
CREATE TABLE [dbo].[pub_info] (
    [pub_id] [char](4) NOT NULL,
    [logo] [image] NULL,
    [pr_info] [text] NULL,
    CONSTRAINT [PK_pub_info] PRIMARY KEY CLUSTERED ([pub_id] ASC),
    CONSTRAINT [FK__pub_info__pub_id__571DF1D5] FOREIGN KEY ([pub_id])
        REFERENCES [dbo].[publishers] ([pub_id])
);

-- Stores table
CREATE TABLE [dbo].[stores] (
    [stor_id] [char](4) NOT NULL,
    [stor_name] [varchar](40) NULL,
    [stor_address] [varchar](40) NULL,
    [city] [varchar](20) NULL,
    [state] [char](2) NULL,
    [zip] [char](5) NULL,
    CONSTRAINT [PK_stores] PRIMARY KEY CLUSTERED ([stor_id] ASC)
);

-- Jobs table
CREATE TABLE [dbo].[jobs] (
    [job_id] [smallint] NOT NULL,
    [job_desc] [varchar](50) NOT NULL DEFAULT ('New Position - title not formalized yet'),
    [min_lvl] [tinyint] NOT NULL,
    [max_lvl] [tinyint] NOT NULL,
    CONSTRAINT [PK_jobs] PRIMARY KEY CLUSTERED ([job_id] ASC)
);

-- Employee table
CREATE TABLE [dbo].[employee] (
    [emp_id] [char](9) NOT NULL,
    [fname] [varchar](20) NOT NULL,
    [minit] [char](1) NULL,
    [lname] [varchar](30) NOT NULL,
    [job_id] [smallint] NOT NULL,
    [job_lvl] [tinyint] NULL,
    [pub_id] [char](4) NOT NULL,
    [hire_date] [datetime] NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED ([emp_id] ASC),
    CONSTRAINT [FK__employee__job_id__5BE2A6F2] FOREIGN KEY ([job_id])
        REFERENCES [dbo].[jobs] ([job_id]),
    CONSTRAINT [FK__employee__pub_id] FOREIGN KEY ([pub_id])
        REFERENCES [dbo].[publishers] ([pub_id])
);

-- Titles table
CREATE TABLE [dbo].[titles] (
    [title_id] [varchar](6) NOT NULL,
    [title] [varchar](80) NOT NULL,
    [type] [char](12) NOT NULL DEFAULT ('UNDECIDED'),
    [pub_id] [char](4) NULL,
    [price] [money] NULL,
    [advance] [money] NULL,
    [royalty] [int] NULL,
    [ytd_sales] [int] NULL,
    [notes] [varchar](200) NULL,
    [pubdate] [datetime] NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_titles] PRIMARY KEY CLUSTERED ([title_id] ASC),
    CONSTRAINT [FK__titles__pub_id__412EB0B6] FOREIGN KEY ([pub_id])
        REFERENCES [dbo].[publishers] ([pub_id])
);

-- Royalty schedule table
CREATE TABLE [dbo].[roysched] (
    [title_id] [varchar](6) NOT NULL,
    [lorange] [int] NULL,
    [hirange] [int] NULL,
    [royalty] [int] NULL,
    CONSTRAINT [FK__roysched__title___4D94879B] FOREIGN KEY ([title_id])
        REFERENCES [dbo].[titles] ([title_id])
);

-- Title Author junction table
CREATE TABLE [dbo].[titleauthor] (
    [au_id] [varchar](11) NOT NULL,
    [title_id] [varchar](6) NOT NULL,
    [au_ord] [tinyint] NULL,
    [royaltyper] [int] NULL,
    CONSTRAINT [PK_titleauthor] PRIMARY KEY CLUSTERED (
        [au_id] ASC,
        [title_id] ASC
    ),
    CONSTRAINT [FK__titleauth__title__45F365D3] FOREIGN KEY ([title_id])
        REFERENCES [dbo].[titles] ([title_id])
);

-- Discounts table
CREATE TABLE [dbo].[discounts] (
    [discounttype] [varchar](40) NOT NULL,
    [stor_id] [char](4) NULL,
    [lowqty] [smallint] NULL,
    [highqty] [smallint] NULL,
    [discount] [decimal](4,2) NOT NULL,
    CONSTRAINT [FK__discounts__stor___4F7CD00D] FOREIGN KEY ([stor_id])
        REFERENCES [dbo].[stores] ([stor_id])
);

-- Sales table
CREATE TABLE [dbo].[sales] (
    [stor_id] [char](4) NOT NULL,
    [ord_num] [varchar](20) NOT NULL,
    [title_id] [varchar](6) NOT NULL,
    [ord_date] [datetime] NOT NULL,
    [qty] [smallint] NOT NULL,
    [payterms] [varchar](12) NOT NULL,
    CONSTRAINT [PK_sales] PRIMARY KEY CLUSTERED (
        [stor_id] ASC,
        [ord_num] ASC,
        [title_id] ASC
    ),
    CONSTRAINT [FK__sales__stor_id__4AB81AF0] FOREIGN KEY ([stor_id])
        REFERENCES [dbo].[stores] ([stor_id]),
    CONSTRAINT [FK__sales__title_id__4BAC3F29] FOREIGN KEY ([title_id])
        REFERENCES [dbo].[titles] ([title_id])
);

-- Create indexes (optional, but recommended for performance)
CREATE INDEX [employee_ind] ON [dbo].[employee]([lname], [fname], [minit]);
CREATE INDEX [titleidind] ON [dbo].[titles]([title_id]);
CREATE INDEX [titleind] ON [dbo].[titles]([title]);
CREATE INDEX [auidind] ON [dbo].[titleauthor]([au_id]);
CREATE INDEX [titleidind] ON [dbo].[titleauthor]([title_id]);
CREATE INDEX [salesind] ON [dbo].[sales]([title_id]);
CREATE INDEX [titleidind] ON [dbo].[roysched]([title_id]);