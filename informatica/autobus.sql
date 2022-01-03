-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 18, 2021 alle 19:10
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autobus`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `account`
--

CREATE TABLE `account` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `cellulare` int(11) UNSIGNED NOT NULL,
  `autista` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `impiegato` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `amministratore` tinyint(4) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `bus`
--

CREATE TABLE `bus` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_tipologiaBus` int(10) UNSIGNED NOT NULL,
  `cod. telario` varchar(50) NOT NULL,
  `targa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `corsa`
--

CREATE TABLE `corsa` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_orario` int(11) UNSIGNED NOT NULL,
  `id_fermata` int(11) UNSIGNED NOT NULL,
  `data` date NOT NULL,
  `orario_fermata` int(11) UNSIGNED NOT NULL,
  `passeggeri` int(11) UNSIGNED NOT NULL,
  `codice` varchar(50) NOT NULL,
  `id_autista` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `fermata`
--

CREATE TABLE `fermata` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome_fermata` int(11) UNSIGNED NOT NULL,
  `posizione` point NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `giorno`
--

CREATE TABLE `giorno` (
  `id` int(11) UNSIGNED NOT NULL,
  `giorno` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `orario`
--

CREATE TABLE `orario` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_giorno` int(11) UNSIGNED NOT NULL,
  `orario_partenza` time NOT NULL,
  `id_bus` int(11) UNSIGNED NOT NULL,
  `id_tratta` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine_fermate`
--

CREATE TABLE `ordine_fermate` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_tratta` int(11) UNSIGNED NOT NULL,
  `ordine` int(11) UNSIGNED NOT NULL,
  `fermata` int(11) UNSIGNED NOT NULL,
  `dif_tempo` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `prenotazioni`
--

CREATE TABLE `prenotazioni` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_account` int(11) UNSIGNED NOT NULL,
  `id_orario` int(11) UNSIGNED NOT NULL,
  `time_reservation` datetime NOT NULL,
  `id_fermata_partenza` int(11) UNSIGNED NOT NULL,
  `id_fermata_finale` int(11) UNSIGNED NOT NULL,
  `confermata` tinyint(4) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `tipologia_bus`
--

CREATE TABLE `tipologia_bus` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(50) NOT NULL,
  `posti` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `tratta`
--

CREATE TABLE `tratta` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bus_tipologia_bus` (`id_tipologiaBus`);

--
-- Indici per le tabelle `corsa`
--
ALTER TABLE `corsa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_corsa_orario` (`id_orario`),
  ADD KEY `FK_corsa_fermata` (`id_fermata`);

--
-- Indici per le tabelle `fermata`
--
ALTER TABLE `fermata`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `giorno`
--
ALTER TABLE `giorno`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `orario`
--
ALTER TABLE `orario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_orario_giorno` (`id_giorno`),
  ADD KEY `FK_orario_bus` (`id_bus`),
  ADD KEY `FK_orario_tratta` (`id_tratta`);

--
-- Indici per le tabelle `ordine_fermate`
--
ALTER TABLE `ordine_fermate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ordine_fermate_tratta` (`id_tratta`),
  ADD KEY `FK_ordine_fermate_fermata` (`fermata`);

--
-- Indici per le tabelle `prenotazioni`
--
ALTER TABLE `prenotazioni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_prenotazioni_account` (`id_account`),
  ADD KEY `FK_prenotazioni_orario` (`id_orario`),
  ADD KEY `FK_prenotazioni_fermata` (`id_fermata_partenza`),
  ADD KEY `FK_prenotazioni_fermata_2` (`id_fermata_finale`);

--
-- Indici per le tabelle `tipologia_bus`
--
ALTER TABLE `tipologia_bus`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `tratta`
--
ALTER TABLE `tratta`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `bus`
--
ALTER TABLE `bus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `corsa`
--
ALTER TABLE `corsa`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `fermata`
--
ALTER TABLE `fermata`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `orario`
--
ALTER TABLE `orario`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `ordine_fermate`
--
ALTER TABLE `ordine_fermate`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `prenotazioni`
--
ALTER TABLE `prenotazioni`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `tipologia_bus`
--
ALTER TABLE `tipologia_bus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `tratta`
--
ALTER TABLE `tratta`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `bus`
--
ALTER TABLE `bus`
  ADD CONSTRAINT `FK_bus_tipologia_bus` FOREIGN KEY (`id_tipologiaBus`) REFERENCES `tipologia_bus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `corsa`
--
ALTER TABLE `corsa`
  ADD CONSTRAINT `FK_corsa_fermata` FOREIGN KEY (`id_fermata`) REFERENCES `fermata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_corsa_orario` FOREIGN KEY (`id_orario`) REFERENCES `orario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `orario`
--
ALTER TABLE `orario`
  ADD CONSTRAINT `FK_orario_bus` FOREIGN KEY (`id_bus`) REFERENCES `bus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_orario_giorno` FOREIGN KEY (`id_giorno`) REFERENCES `giorno` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_orario_tratta` FOREIGN KEY (`id_tratta`) REFERENCES `tratta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `ordine_fermate`
--
ALTER TABLE `ordine_fermate`
  ADD CONSTRAINT `FK_ordine_fermate_fermata` FOREIGN KEY (`fermata`) REFERENCES `fermata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_ordine_fermate_tratta` FOREIGN KEY (`id_tratta`) REFERENCES `tratta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `prenotazioni`
--
ALTER TABLE `prenotazioni`
  ADD CONSTRAINT `FK_prenotazioni_account` FOREIGN KEY (`id_account`) REFERENCES `account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_prenotazioni_fermata` FOREIGN KEY (`id_fermata_partenza`) REFERENCES `fermata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_prenotazioni_fermata_2` FOREIGN KEY (`id_fermata_finale`) REFERENCES `fermata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_prenotazioni_orario` FOREIGN KEY (`id_orario`) REFERENCES `orario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
