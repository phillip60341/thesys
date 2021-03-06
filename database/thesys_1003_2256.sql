USE [master]
GO
/****** Object:  Database [thesys]    Script Date: 10/3/2017 22:56:50 ******/
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
/****** Object:  User [thesys_system]    Script Date: 10/3/2017 22:56:51 ******/
CREATE USER [thesys_system] FOR LOGIN [thesys_system] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblColleges]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblColleges](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblColleges] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPrograms]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPrograms](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[college_id] [int] NOT NULL,
	[name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblPrograms] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 10/3/2017 22:56:51 ******/
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
	[active] [int] NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_Students]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Students]
AS
SELECT        u.id AS student_id, u.user_name, u.last_name, u.first_name, u.middle_name, u.expiry_date, u.id_number, c.id AS college_id, c.name AS college_name, p.id AS program_id, p.name AS program_name
FROM            dbo.tblUsers AS u LEFT OUTER JOIN
                         dbo.tblColleges AS c ON u.college_id = c.id LEFT OUTER JOIN
                         dbo.tblPrograms AS p ON u.program_id = p.id

GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCitation_Format]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCitation_Format](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[format] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblCitation_Format] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDepartment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[college_id] [int] NOT NULL,
	[name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblDepartment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPasswords]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPasswords](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblPasswords] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProponents]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProponents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](150) NOT NULL,
	[middle_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblProponents] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRequest]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRequest](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date_time] [datetime] NOT NULL,
	[upload_code] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRequest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTags]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTags](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis]    Script Date: 10/3/2017 22:56:51 ******/
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
	[request_id] [int] NULL,
 CONSTRAINT [PK_tblThesis] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Abstract]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Abstract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[image] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblThesis_Abstract] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Citations]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Citations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_tblThesis_Citations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Evaluators]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Evaluators](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[evaluator_id] [int] NOT NULL,
	[thesis_id] [int] NOT NULL,
 CONSTRAINT [PK_tblThesis_Evaluators] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Tags]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Tags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[thesis_id] [int] NOT NULL,
	[tag_id] [int] NOT NULL,
 CONSTRAINT [PK_tblThesis_Tags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblThesis_Views]    Script Date: 10/3/2017 22:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblThesis_Views](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[thesis_id] [int] NOT NULL,
	[date_time] [datetime] NOT NULL,
 CONSTRAINT [PK_tblThesis_Views] PRIMARY KEY CLUSTERED 
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

INSERT [dbo].[tblPasswords] ([id], [user_id], [password]) VALUES (6, 8, N'뉺煮�➾ꌞﷆ㚄')
INSERT [dbo].[tblPasswords] ([id], [user_id], [password]) VALUES (7, 9, N'廬鐞䋀ꏝ∸ᩰぞ')
SET IDENTITY_INSERT [dbo].[tblPasswords] OFF
SET IDENTITY_INSERT [dbo].[tblPrograms] ON 

INSERT [dbo].[tblPrograms] ([id], [college_id], [name]) VALUES (1, 1, N'BSCS Application Development')
SET IDENTITY_INSERT [dbo].[tblPrograms] OFF
SET IDENTITY_INSERT [dbo].[tblUsers] ON 

INSERT [dbo].[tblUsers] ([id], [user_name], [last_name], [first_name], [middle_name], [expiry_date], [type], [id_number], [college_id], [program_id], [active]) VALUES (8, N'pelp', N'Villaver', N'Ray Vincent Phillip', N'Dineros', CAST(N'2017-10-03' AS Date), N'Student', N'K1124884', 1, 1, 1)
INSERT [dbo].[tblUsers] ([id], [user_name], [last_name], [first_name], [middle_name], [expiry_date], [type], [id_number], [college_id], [program_id], [active]) VALUES (9, N'ella', N'Dela Cruz', N'Ellalaine Mae', N'Coraje', CAST(N'2017-10-03' AS Date), N'Student', N'K5140022', 3, 1, 1)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "u"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 215
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Students'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Students'
GO
USE [master]
GO
ALTER DATABASE [thesys] SET  READ_WRITE 
GO
