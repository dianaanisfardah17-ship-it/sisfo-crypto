-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 15, 2026 at 03:40 PM
-- Server version: 8.0.30
-- PHP Version: 8.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sisfo_crypto`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_config`
--

CREATE TABLE `auth_config` (
  `id` int NOT NULL,
  `pass_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_config`
--

INSERT INTO `auth_config` (`id`, `pass_hash`, `public_key`, `created_at`) VALUES
(2, '$2y$12$xvKCpe/8QPtiU75vc8OmuOfFKmMDSYdjMJF.wDkuKWQCXz4bODtnO', '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmWIi46gYzWf2RQo1l0DH\nxtWzDg4gUykcW1mAsjmKpweIMz6TT/l7VDd0zr5KUOFX8qz4JnhuAo5oFpcQbccf\n2IqsD1yFolPA1uJPyf63OGfDJUxXUR2QUvE+AxpvMQW+u5dxQZu0IKILq+paWBP1\nVCW5pqh9RH0lHijS4+QIjCNtH8OiE+WfbqRxhzRuqvPFJyToA3iIfflpvH56Cu7+\nSzliPgB6hsZyJSx8UVMKY7TnjORNILU3y3BapDbkw3wVsy5B4C3RBQUk5fLLfRoU\nFEzi/SxW3h+vTdg3ZzyiGLGWjDDF2nkzVkXloG16Y1gLCgds1F00BCWm36yI4Eh6\nAQIDAQAB\n-----END PUBLIC KEY-----\n', '2026-11-15 15:36:22');

-- --------------------------------------------------------

--
-- Table structure for table `records`
--

CREATE TABLE `records` (
  `id` int NOT NULL,
  `judul_enc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi_enc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `wrapped_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `records`
--

INSERT INTO `records` (`id`, `judul_enc`, `isi_enc`, `wrapped_key`, `created_at`) VALUES
(7, 'GJgngThmSVJ5K0hw9Zy2CUP8ocjzME1x/8zpt6iG9SmPrE095gjahDbfrpqYnu4M6nWDkjc=', 'v/X78y32+xquNSQ9hc+fNQSd2sP8DiibVQGH/RXwBoBvknSbxCPKGTN6MuRZKD/Yc0VGyJBXKj5CUErColAWVUARNcmtFZybtJmDXXmK9Q260bsCP0I3LDxDe0aaaXIM/NokvmvQNjMNXrC1EuJjR0Jwjb6qYCCxolHSykHh2EUcvFfP1vR9JUTv0tH6Zcs=', 'iME6ksFIxsDGRemd93woU5bOIvFGdSLaBvRzWbrA0slkEl9AOQvXJgpVdXCqRqio0009OlPSddVjJvj0nL+0okBol4Nxk0XTI052TQmK/nKf9JdUOMHtaXyIHeU9X1gjLIRGKeDtpga2j7lk16CPOmQNAx/PLr95oDuafBysNFycXomm5rESvnKYlHBuokZ2UJAZSeEdIDyzqeMzR9waoPZ6oxU+OSyezg6LdFG2tul/0R4eQn1kCydrxvUHxg4VMYc4JvzZt6NvLwolDlmWgInZ6/r8ua2lkfwbq1e8nf0u+egD+oZt6qiHp6gU28bOTgUlcECxiITx6TY1GrUCpw==', '2026-11-15 15:39:45'),
(8, '/UkwAgRHJ2VR9ggwEuQ7fBdPsV2lsr7P33HYKRtq6EguO3QVpHc1WDfZnxqAFgeT0O/C', 'RfyKobNIHfcq9AmiURE3Hy1z6IGzqtF6LvqRqCwVuzIah+o5+cdiN+2fbMNPXodQfUs5tOy+q+paG8qBD21FiN70yYCEwW0YfoUk5+8wObjqd1Lft1eIxVWNj2O5r1xVoL5AvJNrJNr0kNIHVM+ftToP0Iuodd/W', 'dDPOXNa96/KcNLds1zh7ogB98ygaSXNYMU6wNWBHVze6C/ocTC0Y7Wi/RKyNTAYB4Yf8hQr6uOKla/UZDGjpu5sJ2YPOeO+EqNrIKqExkW/s3hqXE4QWQBXkgkjhPeIwvT10F5lqQzomNHYE36qkx5Aj9ku2ev+cmYmeVBbT8ovjo+R4ux77/t/yUsdXGJNnOOmmDv3Pl0UOz6Z15LNpUCyRHpn4godZJvzCwi54/m0zjuSdZeAN6TOTVk3e8WgOwU/S4hG+KUWoloEkWOlvqKsYzFTtBivLZEG3KEE3NpFdk5AOBXKPmnyqLZo6h1DA400C/g93lST2oLV8+twzoQ==', '2026-11-15 15:39:45'),
(9, 'yNWQ2AT3ZvG1N1LxP6f1Bpy1MLQCgiUrbrtH5didyErD0KpfyefCx6TZ42pAyg==', 'g/8lLIsgHqPXQiYCQtVUgmnE0TQUZ5hDDrQsWPbcnqw29qzznAKSWa+otHVTAzqX5iXEO9AiE7q/ZD+MH27feosNSDhVg2SIk1x55JcpHo4/F39k2Hu+uVUjM+bwb6o+gG+cd6+PBnnS025C', 'R7F9QLMHZZQmgAOjoPfeVI3lXI9Dv5OyEiYeU8E48iUNQwi8+cRjTKyop5GocbEBgIKm0T73YWFkeoaIyr3I3sCXw5WgqIK2m+Sq9vBRDkbFtMxCzhSU6cEhHKU1XloOK7qUBg99qgyv3Dx6ZYRb+jy4j8WF7FjrT3MtPURInh6Sd/StGcK0qrRWKkfxkM410lfsSiUOYe9rGqUfNAP3FglnopYgNKYGvjeh2HK4oyfNbjmBuURZxNO/jfPCA6noxnToN9WdgRNhQx5Be6lUk6E1aqhBKlhj3Pj4SsfSrrUBzyJVwDmlwuF7/ZrZR9kwImSVZNHDlvpkRCtGIys0oQ==', '2026-11-15 15:39:45'),
(10, 'G2RkIKCLV0sFGlXW4p78q30L1tsJ9fl/28yEbIprUiK5Wn414D1wL0kNLVBfQygMWhVjNg0e', 'EYNk9JMAkorQfmLAvQE9bc0f1D2XPg+gg7wSEPp9OHYPFFNtMnvqH8uPhcT9lZLcOoN4xrM7x3OTnEARKkATpbKD7EuvNL/9W0YvIC9FcH6aK49vxOb/23hNi7zg+U8XKkeksuufXfChmb9R1xg=', 'jbK0r1ckKD+/VLsog1xWMhfkDKElYIK2ho7wEAQsOAHawYEiXSecFdO5oSUYNF22aZBC84BT91l2W/dH6JNCysL9JzfWSRo2jB874t+NUajyifHWcSbcQuHwVRDIdpD9OECQhgu1DZkzZ6Y0TF6ID9YNhMH8e6gUsaN67uLsyXibC3szUwc3BV1PjYDfDfuezyzGH4CvLNujOZZ5Up9M/PGO0/+Sonv+7jOVTR7XpQXmVV8EzSTjH8b6EjBo2b+UUXeMa0LJ64g8nth3rGLaxv8PShgLigwcLZeWqVQQyD4NQAYpmd8kNtWCbRadsejlLLZIaYl2QB8YwgJ4SwuQ4A==', '2026-11-15 15:39:45'),
(11, 'bAwcD198q3pvqP2SGJ/iQh1hRrRGSmjJ5xW/CNAOWWu6E8XUKxyAiMv1Me65ow==', '8zS/Nhbs6Qf/cy46ChVdGJSlKbWgT2TxNUHdcsO3YtkLsGlIXmX/mxDLbyLavltzYODnTOOsW2MIUHBmBoFah2qpj/VP1U+bXm0wqxtiRAj8sIOSipvsROTGdtRjYLCH7L9qnm3oXu5cqEqJG8O99Qps', 'FTYwD66tqW99Hbry38CLbYiZcLo1t1CIkqgwzVR+6n0hDrw51ITOj87+1arD0aDHLTJtJqvW7K0sTzYgsYu1IsmfdlVZ5PpPfyhlTBU4UbaQIVADJvjSwT6QjBNKglRSVB1ythgG9ERJK5jsegaLymg13eMBp/zAckD8Kptrn35DqTv6a1xmna39bwLfqYuRXYNsdbTguf4Fx9gwmw3ulPB/VnY1mvkEHemrHAC/3OD8fyyKPYTsqVqeTtxmRSBfxju068ziIaOBtWGtxIvpXpz1nm0VET4sNKku4ktJQVGyIFXLRgxc2RWATU17xMumDG1EcpHOEBgtnnpyQMpolg==', '2026-11-15 15:39:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_config`
--
ALTER TABLE `auth_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records`
--
ALTER TABLE `records`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_config`
--
ALTER TABLE `auth_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `records`
--
ALTER TABLE `records`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
