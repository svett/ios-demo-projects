SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `GoldenGekkoItemsDb` DEFAULT CHARACTER SET utf32 ;
USE `GoldenGekkoItemsDb` ;

-- -----------------------------------------------------
-- Table `GoldenGekkoItemsDb`.`Items`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `GoldenGekkoItemsDb`.`Items` (
  `id` INT(11) NOT NULL ,
  `title` VARCHAR(250) NULL DEFAULT NULL ,
  `link` VARCHAR(250) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf32;


INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
1,
"Seven is my lucky number",
"/api/v10/items/1"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
2,
"A Dance with Dragons",
"/api/v10/items/2"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
3,
"Ten ways to a better mind",
"/api/v10/items/3"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
4,
"The Hitch-hikers Guide to the Galaxy",
"/api/v10/items/4"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
5,
"The Girl with the Dragon Tattoo",
"/api/v10/items/5"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
6,
"Seven Eleven",
"/api/v10/items/6"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
7,
"The Firm",
"/api/v10/items/7"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
8,
"Harry Potter",
"/api/v10/items/8"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
9,
"Nine to Five",
"/api/v10/items/9"
);

INSERT INTO `GoldenGekkoItemsDb`.`Items`
(`id`,
`title`,
`link`)
VALUES
(
10,
"Ben Tennyson",
"/api/v10/items/10"
);


-- -----------------------------------------------------
-- Table `GoldenGekkoItemsDb`.`ItemDetails`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `GoldenGekkoItemsDb`.`ItemDetails` (
  `id` INT(11) NOT NULL ,
  `image` VARCHAR(250) NULL DEFAULT NULL ,
  `author` VARCHAR(250) NULL DEFAULT NULL ,
  `price` DOUBLE NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `foreignkey_id`
    FOREIGN KEY (`id` )
    REFERENCES `GoldenGekkoItemsDb`.`Items` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf32;

USE `GoldenGekkoItemsDb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
1,
"no-image",
"Mike Robinson",
10.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
2,
"no-image",
"John Jackson",
40.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
3,
"no-image",
"Jerry J.",
55.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
4,
"no-image",
"John Q.",
23.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
5,
"no-image",
"Paul Rossi",
76.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
6,
"no-image",
"Unknown",
8.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
7,
"no-image",
"Morgan Freeman",
3.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
8,
"no-image",
"Peter Sue",
12.0
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
9,
"no-image",
"Harry Potter",
9.99
);

INSERT INTO `GoldenGekkoItemsDb`.`ItemDetails`
(`id`,
`image`,
`author`,
`price`)
VALUES
(
10,
"no-image",
"Jackson Hole",
1.99
);


