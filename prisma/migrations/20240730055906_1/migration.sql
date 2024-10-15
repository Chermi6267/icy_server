-- CreateTable
CREATE TABLE `Role` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Role_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `hashPassword` VARCHAR(191) NULL,
    `loggedWith` VARCHAR(191) NOT NULL,
    `roleId` INTEGER NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `token` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `token` CHAR(255) NOT NULL,
    `userId` INTEGER NOT NULL,

    UNIQUE INDEX `token_token_key`(`token`),
    UNIQUE INDEX `token_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Profile` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NULL,
    `avatar` VARCHAR(191) NULL,
    `userId` INTEGER NOT NULL,

    UNIQUE INDEX `Profile_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AdminCenter` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `capital` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `AdminCenter_id_key`(`id`),
    UNIQUE INDEX `AdminCenter_name_key`(`name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Category_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Landmark` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `latitude` DECIMAL(10, 7) NOT NULL,
    `longitude` DECIMAL(10, 7) NOT NULL,
    `link` VARCHAR(191) NOT NULL,
    `description` MEDIUMTEXT NOT NULL,
    `rating` DECIMAL(3, 2) NOT NULL,
    `adminCenterId` VARCHAR(191) NULL,

    UNIQUE INDEX `Landmark_name_key`(`name`),
    UNIQUE INDEX `Landmark_link_key`(`link`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `LandmarkPhoto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `photoPath` VARCHAR(191) NOT NULL,
    `landmarkId` INTEGER NOT NULL,

    UNIQUE INDEX `LandmarkPhoto_photoPath_key`(`photoPath`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` MEDIUMTEXT NOT NULL,
    `stars` DECIMAL(2, 1) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `userId` INTEGER NOT NULL,
    `landmarkId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Tour` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `description` MEDIUMTEXT NOT NULL,

    UNIQUE INDEX `Tour_title_key`(`title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_CategoryToLandmark` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_CategoryToLandmark_AB_unique`(`A`, `B`),
    INDEX `_CategoryToLandmark_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_LandmarkToTour` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_LandmarkToTour_AB_unique`(`A`, `B`),
    INDEX `_LandmarkToTour_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `Role`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `token` ADD CONSTRAINT `token_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Landmark` ADD CONSTRAINT `Landmark_adminCenterId_fkey` FOREIGN KEY (`adminCenterId`) REFERENCES `AdminCenter`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LandmarkPhoto` ADD CONSTRAINT `LandmarkPhoto_landmarkId_fkey` FOREIGN KEY (`landmarkId`) REFERENCES `Landmark`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_landmarkId_fkey` FOREIGN KEY (`landmarkId`) REFERENCES `Landmark`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CategoryToLandmark` ADD CONSTRAINT `_CategoryToLandmark_A_fkey` FOREIGN KEY (`A`) REFERENCES `Category`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CategoryToLandmark` ADD CONSTRAINT `_CategoryToLandmark_B_fkey` FOREIGN KEY (`B`) REFERENCES `Landmark`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_LandmarkToTour` ADD CONSTRAINT `_LandmarkToTour_A_fkey` FOREIGN KEY (`A`) REFERENCES `Landmark`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_LandmarkToTour` ADD CONSTRAINT `_LandmarkToTour_B_fkey` FOREIGN KEY (`B`) REFERENCES `Tour`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
