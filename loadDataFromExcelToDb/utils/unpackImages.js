const fs = require("fs");
const path = require("path");

const defaultFolderPath = path.join(__dirname, "../../public/img/default");
const smallFolderPath = path.join(__dirname, "../../public/img/small");

// fs.readdir(defaultFolderPath, (err, files) => {
//   if (err) {
//     console.error("Error reading directory 1:", err);
//     return;
//   }

//   files.forEach(async (file) => {
//     const imgFolder = path.join(defaultFolderPath, file);

//     fs.readdir(imgFolder, (err, files) => {
//       if (err) {
//         console.error("Error reading directory 2:", err);
//         return;
//       }

//       files.forEach((file) => {
//         fs.rename(
//           path.join(imgFolder, file),
//           path.join(imgFolder, "../", file),
//           (err) => {
//             if (err) {
//               console.log(err);
//             } else {
//               console.log(`Файл ${file} перемещен`);
//             }
//           }
//         );
//       });
//     });
//   });
// });

fs.readdir(smallFolderPath, (err, files) => {
  if (err) {
    console.error("Error reading directory 1:", err);
    return;
  }

  files.forEach(async (file) => {
    const imgFolder = path.join(smallFolderPath, file);

    fs.readdir(imgFolder, (err, files) => {
      if (err) {
        console.error("Error reading directory 2:", err);
        return;
      }

      files.forEach((file) => {
        fs.rename(
          path.join(imgFolder, file),
          path.join(imgFolder, "../", file),
          (err) => {
            if (err) {
              console.log(err);
            } else {
              console.log(`Файл ${file} перемещен`);
            }
          }
        );
      });
    });
  });
});
