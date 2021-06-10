-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2021 at 03:45 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `online-quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `questionid` varchar(9) NOT NULL,
  `question` varchar(100) NOT NULL,
  `quizid` int(9) NOT NULL,
  `option1` varchar(50) NOT NULL,
  `option2` varchar(50) NOT NULL,
  `option3` varchar(50) NOT NULL,
  `option4` varchar(50) NOT NULL,
  `correctanswer` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL COMMENT 'MCQ, Open, FIB',
  `correctPoints` int(2) NOT NULL DEFAULT 1,
  `minusPoints` int(2) NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`questionid`, `question`, `quizid`, `option1`, `option2`, `option3`, `option4`, `correctanswer`, `type`, `correctPoints`, `minusPoints`, `timestamp`) VALUES
('4ViEy2', 'Question 1', 825122, 'D', 'B', 'C', 'A', '4', 'MCQ', 1, 0, '2021-06-10 01:04:30'),
('7BNTU4', 'Question 3', 641396, 'Op1', 'Op2', 'Op3', 'Op4', '2', 'MCQ', 1, 0, '2021-06-10 13:43:32'),
('aCcpPC', 'Question 1', 641396, 'A', 'B', 'C', 'D', '1', 'MCQ', 1, 0, '2021-06-10 12:28:46'),
('bpM7PP', 'Question 2', 641396, 'A', 'B', 'C', 'D', '2', 'MCQ', 1, 0, '2021-06-10 12:28:57'),
('CuS2Y4', 'Question 5', 641396, 'D', 'C', 'B', 'A', '4', 'MCQ', 1, 0, '2021-06-10 15:14:46'),
('CyOV2d', 'Question 3', 825122, 'A', 'B', 'C', 'D', '2', 'MCQ', 1, 0, '2021-06-10 11:08:36'),
('dliASA', 'Question 1', 143982, 'A', 'B', 'C', 'D', '1', 'MCQ', 1, 0, '2021-06-10 17:03:06'),
('hN8bd0', 'Question 1', 628732, 'A', 'B', 'C', 'D', '3', 'MCQ', 1, 0, '2021-06-10 10:23:22'),
('jGgRSd', 'Question 2', 143982, 'A', 'B', 'C', 'D', '4', 'MCQ', 1, 0, '2021-06-10 17:03:25'),
('SXpbcA', 'Question 2', 667623, 'Op1', 'Op3', 'Op4', 'Op2', '4', 'MCQ', 1, 0, '2021-06-10 12:25:03'),
('TkXEs1', 'Question 4', 641396, 'ABCD', 'EFGH', 'IJKL', 'MNOP', '1', 'MCQ', 1, 0, '2021-06-10 13:49:42');

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `quizid` int(9) NOT NULL,
  `quizname` varchar(100) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizid`, `quizname`, `username`, `timestamp`) VALUES
(143982, 'Quiz 2', 'pradeep', '2021-06-10 14:48:27'),
(641396, 'Quiz 3', 'pradeep', '0000-00-00 00:00:00'),
(667623, 'Quiz 1 - Milind Modi', 'milind', '2021-06-10 12:24:19');

-- --------------------------------------------------------

--
-- Table structure for table `scoreboard`
--

CREATE TABLE `scoreboard` (
  `questionid` varchar(9) NOT NULL,
  `username` varchar(20) NOT NULL,
  `selected` varchar(50) NOT NULL,
  `isCorrect` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `scoreboard`
--

INSERT INTO `scoreboard` (`questionid`, `username`, `selected`, `isCorrect`) VALUES
('7BNTU4', 'milind', '1', 0),
('aCcpPC', 'pradeep', '4', 0),
('aCcpPC', 'nirav', '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `name`, `email`) VALUES
('milind', 'milind', 'Milind Modi', 'milind@modi.com'),
('nirav', 'nirav', 'Nirav Chavda', 'nirav@chavda.com'),
('pradeep', 'pradeep', 'Pradeep Karamakar', 'pradeep@pk.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`questionid`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quizid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `email` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
