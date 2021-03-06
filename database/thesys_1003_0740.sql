USE [master]
GO
/****** Object:  Database [thesys]    Script Date: 10/3/2017 07:40:56 ******/
CREATE DATABASE [thesys]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'thesys', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\thesys.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'thesys_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\thesys_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [thesys] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [thesys].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [thesys] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [thesys] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [thesys] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [thesys] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [thesys] SET ARITHABORT OFF 
GO
ALTER DATABASE [thesys] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [thesys] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [thesys] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [thesys] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [thesys] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [thesys] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [thesys] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [thesys] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [thesys] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [thesys] SET  DISABLE_BROKER 
GO
ALTER DATABASE [thesys] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [thesys] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [thesys] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [thesys] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [thesys] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [thesys] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [thesys] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [thesys] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [thesys] SET  MULTI_USER 
GO
ALTER DATABASE [thesys] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [thesys] SET DB_CHAINING OFF 
GO
ALTER DATABASE [thesys] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [thesys] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [thesys] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [thesys] SET QUERY_STORE = OFF
GO
USE [thesys]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [thesys]
GO
/****** Object:  User [thesys_system]    Script Date: 10/3/2017 07:40:57 ******/
CREATE USER [thesys_system] FOR LOGIN [thesys_system] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCitation_Format]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCitation_Format](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[format] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblColleges]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblColleges](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDepartment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[college_id] [int] NOT NULL,
	[name] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPasswords]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPasswords](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[password] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPrograms]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPrograms](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[college_id] [int] NOT NULL,
	[name] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProponents]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProponents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](150) NOT NULL,
	[middle_name] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRequest]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRequest](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date_time] [datetime] NOT NULL,
	[upload_code] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTags]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTags](
	[id] [int] NULL,
	[name] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[thesis_file] [nvarchar](max) NULL,
	[file_type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[request_id] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Abstract]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Abstract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[image] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Citations]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Citations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[date_time] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Evaluators]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Evaluators](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[evaluator_id] [int] NOT NULL,
	[thesis_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Tags]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Tags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[tag_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Views]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Views](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[thesis_id] [int] NOT NULL,
	[date_time] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 10/3/2017 07:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](150) NOT NULL,
	[middle_name] [nvarchar](50) NOT NULL,
	[expiry_date] [date] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[id_number] [nvarchar](10) NULL,
	[college_id] [int] NULL,
	[program_id] [int] NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblColleges] ON 

INSERT [dbo].[tblColleges] ([id], [name]) VALUES (1, N'College of Computer Science')
INSERT [dbo].[tblColleges] ([id], [name]) VALUES (2, N'College of Business Administration')
INSERT [dbo].[tblColleges] ([id], [name]) VALUES (3, N'College of Arts and Sciences')
SET IDENTITY_INSERT [dbo].[tblColleges] OFF
SET IDENTITY_INSERT [dbo].[tblPasswords] ON 

INSERT [dbo].[tblPasswords] ([id], [user_id], [password]) VALUES (3, 5, N'粂໋諪汰㑌梡筎')
INSERT [dbo].[tblPasswords] ([id], [user_id], [password]) VALUES (4, 6, N'粂໋諪汰㑌梡筎')
SET IDENTITY_INSERT [dbo].[tblPasswords] OFF
SET IDENTITY_INSERT [dbo].[tblPrograms] ON 

INSERT [dbo].[tblPrograms] ([id], [college_id], [name]) VALUES (1, 1, N'BSCS Application Development')
SET IDENTITY_INSERT [dbo].[tblPrograms] OFF
SET IDENTITY_INSERT [dbo].[tblUsers] ON 

INSERT [dbo].[tblUsers] ([id], [user_name], [last_name], [first_name], [middle_name], [expiry_date], [type], [id_number], [college_id], [program_id]) VALUES (5, N'mark_cabusora', N'Cabusora', N'Mark Joseph', N'Lizertiguez', CAST(N'2017-10-02' AS Date), N'Student', N'K1124567', NULL, NULL)
INSERT [dbo].[tblUsers] ([id], [user_name], [last_name], [first_name], [middle_name], [expiry_date], [type], [id_number], [college_id], [program_id]) VALUES (6, N'erna_castillo', N'Castillo', N'Ernalyn', N'Soliven', CAST(N'2017-10-02' AS Date), N'Student', N'K1127086', 1, 1)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
USE [master]
GO
ALTER DATABASE [thesys] SET  READ_WRITE 
GO
