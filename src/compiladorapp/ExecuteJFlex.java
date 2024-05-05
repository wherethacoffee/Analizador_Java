package compiladorapp;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class ExecuteJFlex {

    public static void main(String args[]) throws IOException {
        String lexerFile = System.getProperty("user.dir") + "/src/compiladorapp/Lexer.flex",
                lexerCupFile = System.getProperty("user.dir") + "/src/compiladorapp/LexerCup.flex";
        String[] sintaxFile = {"-parser", "Sintax", System.getProperty("user.dir") + "/src/compiladorapp/Sintax.cup"};

        try {
            JFlex.Main.generate(new String[]{lexerFile, lexerCupFile});
            java_cup.Main.main(sintaxFile);
            Path rutaSym = Paths.get(System.getProperty("user.dir") + "/src/compiladorapp/sym.java");
            if (Files.exists(rutaSym)) {
                Files.delete(rutaSym);
            }
            Files.move(
                    Paths.get(System.getProperty("user.dir") + "/sym.java"),
                    Paths.get(System.getProperty("user.dir") + "/src/compiladorapp/sym.java")
            );
            Path rutaSin = Paths.get(System.getProperty("user.dir") + "/src/compiladorapp/Sintax.java");
            if (Files.exists(rutaSin)) {
                Files.delete(rutaSin);
            }
            Files.move(
                    Paths.get(System.getProperty("user.dir") + "/Sintax.java"),
                    Paths.get(System.getProperty("user.dir") + "/src/compiladorapp/Sintax.java")
            );
        } catch (Exception ex) {
            System.out.println("Error al generar el archivo flex: " + ex);

        }
    }
}
