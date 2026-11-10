-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 10, 2026 at 03:06 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `contact_manager_2026_am`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contactID` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `emailAddress` varchar(50) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `typeID` int(11) NOT NULL DEFAULT 1,
  `imageName` varchar(50) DEFAULT NULL,
  `userID` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contactID`, `firstName`, `lastName`, `emailAddress`, `phoneNumber`, `dob`, `typeID`, `imageName`, `userID`) VALUES
(8, 'Bugs', 'Bunny', 'bbunny@ltunes.com', '555-555-1111', '1994-02-04', 4, 'Bugs_Bunny_100.png', 1),
(11, 'Daffy', 'Duck', 'dduck@ltunes.com', '555-555-1112', '1985-07-11', 2, 'Daffy_Duck_100.png', 1),
(13, 'Foghorn', 'Leghorn', 'fleghorn@ltunes.com', '555-555-1115', '1992-06-17', 1, 'placeholder_100.jpg', 1),
(14, 'Wiley', 'Coyote', 'wcoyote@ltunes.com', '555-555-1114', '1979-10-26', 1, 'Coyote_100.png', 5),
(15, 'Elmer', 'Fudd', 'efudd@ltunes.com', '555-555-1115', '1995-03-24', 1, 'Fudd_100.png', 5);

-- --------------------------------------------------------

--
-- Table structure for table `registrations`
--

CREATE TABLE `registrations` (
  `userID` int(4) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `emailAddress` varchar(50) NOT NULL,
  `failedAttempts` int(4) DEFAULT NULL,
  `lastFailedLogin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registrations`
--

INSERT INTO `registrations` (`userID`, `userName`, `password`, `emailAddress`, `failedAttempts`, `lastFailedLogin`) VALUES
(1, 'djasper', '$2y$10$hyxlz725MQdHybjUeRBzdO.zHbSTnUUdbffdbuWkvdfAc59Hu5Uo2', 'doug.jasper@trios.com', 0, NULL),
(5, 'djasper2026', '$2y$10$G7cCxTpv22bH2E0x3CkEdON4sJgcY7aFyNr5gq3euqJ4GbRhAuJgO', 'doug.jasper@trios.com', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE `types` (
  `typeID` int(11) NOT NULL,
  `contactType` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`typeID`, `contactType`) VALUES
(1, 'family'),
(2, 'friend'),
(3, 'work'),
(4, 'business'),
(5, 'leisure');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contactID`),
  ADD KEY `FK_typeID` (`typeID`),
  ADD KEY `FK_userID` (`userID`);

--
-- Indexes for table `registrations`
--
ALTER TABLE `registrations`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`typeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `registrations`
--
ALTER TABLE `registrations`
  MODIFY `userID` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `types`
--
ALTER TABLE `types`
  MODIFY `typeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `FK_typeID` FOREIGN KEY (`typeID`) REFERENCES `types` (`typeID`),
  ADD CONSTRAINT `FK_userID` FOREIGN KEY (`userID`) REFERENCES `registrations` (`userID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
