import { fez } from "fez-lisp";
import { readFileSync, access } from "fs";
const path = `./${process.argv[2]}/AT/solution.lisp`;
access(path, (err) => {
  if (err) {
    console.log(`\x1b[31mFile ${path} does not exist\x1b[33m\n`);
  } else {
    const file = readFileSync(path, "utf-8");
    console.log(
      fez(file, {
        mutation: 1,
      })
        .map((x, i) => `\x1b[34mPart ${i + 1}: \x1b[33m${x}\x1b[0m\n`)
        .join("\n")
    );
  }
});
