-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 07 juil. 2022 à 10:59
-- Version du serveur : 10.4.20-MariaDB
-- Version de PHP : 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ingrwf10_php`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `label` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `label`) VALUES
(1, 'new label'),
(2, 'jouets'),
(3, 'outils'),
(4, 'véhicules'),
(6, 'new label');

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `message`) VALUES
(1, 'test', 'test@ss.com', 'dsdsdsd'),
(2, 'inconnu', 'dsdsd@ddd.com', 'ssdsds'),
(3, 'inconnu', 'dsdsd@ddd.com', 'ssdsds'),
(4, 'inconnu', 'dsdsd@ddd.com', 'ssdsds'),
(5, 'inconnu', 'dsdsd@ddd.com', 'ssdsds'),
(6, 'inconnu', 'dsdsd@ddd.com', 'ssdsds'),
(7, 'inconnu', 'dsdsd@ddd.com', 'ssdsds'),
(8, 'pierre charlier', 'charlier.pierre@gmail.com', 'sdsdsdsd');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `marcel`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `marcel` (
`id_personnes` int(10) unsigned
,`nom` varchar(120)
,`prenom` varchar(120)
);

-- --------------------------------------------------------

--
-- Structure de la table `news`
--

CREATE TABLE `news` (
  `id` int(10) UNSIGNED NOT NULL,
  `titre` varchar(200) NOT NULL,
  `contenu` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `news`
--

INSERT INTO `news` (`id`, `titre`, `contenu`) VALUES
(1, 'nouveau titre', 'nouveau contenu'),
(2, 'ti tre d enews 2', 'lorem lorem news 2'),
(3, 'titre de la news 3', 'lorem lore lorem news 3'),
(5, 'essai Pierre', 'lorem ipsum Pierre'),
(6, 'essai Pierre', 'lorem ipsum Pierre'),
(7, 'essai Pierre', 'il s\'agit lorem ipsum Pierre');

-- --------------------------------------------------------

--
-- Structure de la table `personnes`
--

CREATE TABLE `personnes` (
  `id_personnes` int(10) UNSIGNED NOT NULL,
  `nom` varchar(120) DEFAULT NULL,
  `prenom` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `personnes`
--

INSERT INTO `personnes` (`id_personnes`, `nom`, `prenom`) VALUES
(2, 'Proust2', 'Marcel2'),
(6, 'charlier', 'benoit'),
(19, 'devos', 'françoise'),
(22, 'Proust', 'Marcel'),
(23, 'Proust2', 'Marcel2'),
(24, 'Proust2', 'Marcel2'),
(25, 'Proust2', 'Marcel2'),
(26, 'Proust2', 'Marcel2'),
(27, 'NULL', 'Bastien'),
(28, 'Henry', 'Philippe'),
(29, 'Henry2', 'Philippe2'),
(30, 'Henry2', 'Philippe2'),
(31, 'Dupnt', 'Henry'),
(32, 'dupont', 'marcel'),
(33, 'proust', 'Emmanuel'),
(34, 'charlier2', 'pierre2'),
(35, 'test', 'pitou'),
(36, 'charlier2', 'pierre2'),
(37, 'charlier2', 'pierre2'),
(38, 'charlier2', 'pierre2'),
(39, 'charlier2', 'pierre2');

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `id` int(10) UNSIGNED NOT NULL,
  `label` varchar(250) NOT NULL,
  `id_categories` int(11) DEFAULT NULL,
  `prix` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `label`, `id_categories`, `prix`) VALUES
(1, 'pommes', 1, NULL),
(3, 'new label', NULL, 45),
(4, 'poires', 1, NULL),
(5, 'voiture', 4, NULL),
(6, 'poupée', 2, NULL),
(7, 'new label2', NULL, 45.3),
(8, 'new label2', NULL, 45.3),
(9, 'new label2', NULL, 45.3),
(10, 'new label2', NULL, 45.3),
(11, 'new label2', NULL, 45.3);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `produits_categories`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `produits_categories` (
`id` int(10) unsigned
,`label` varchar(250)
,`id_categories` int(11)
,`prix` float
,`id_cat` int(11)
,`cat_label` varchar(250)
);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_users` int(10) UNSIGNED NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_users`, `login`, `password`) VALUES
(1, 'pierre', 'pass');

-- --------------------------------------------------------

--
-- Structure de la vue `marcel`
--
DROP TABLE IF EXISTS `marcel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marcel`  AS SELECT `personnes`.`id_personnes` AS `id_personnes`, `personnes`.`nom` AS `nom`, `personnes`.`prenom` AS `prenom` FROM `personnes` WHERE `personnes`.`prenom` like '%marcel%' ;

-- --------------------------------------------------------

--
-- Structure de la vue `produits_categories`
--
DROP TABLE IF EXISTS `produits_categories`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `produits_categories`  AS SELECT `produits`.`id` AS `id`, `produits`.`label` AS `label`, `produits`.`id_categories` AS `id_categories`, `produits`.`prix` AS `prix`, `categories`.`id` AS `id_cat`, `categories`.`label` AS `cat_label` FROM (`produits` left join `categories` on(`produits`.`id_categories` = `categories`.`id`)) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD PRIMARY KEY (`id_personnes`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categories` (`id_categories`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `personnes`
--
ALTER TABLE `personnes`
  MODIFY `id_personnes` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `produits_ibfk_1` FOREIGN KEY (`id_categories`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
