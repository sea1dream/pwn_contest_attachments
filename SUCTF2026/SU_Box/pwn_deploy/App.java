import com.eclipsesource.v8.*;
import java.io.*;

public class App {
    private static final int MAX_SCRIPT_SIZE = 1048576;

    public static void main(String[] args) throws Exception {
        System.out.println("  ____  _   _ ____            ");
        System.out.println(" / ___|| | | | __ )  _____  __");
        System.out.println(" \\___ \\| | | |  _ \\ / _ \\ \\/ /");
        System.out.println("  ___) | |_| | |_) | (_) >  < ");
        System.out.println(" |____/ \\___/|____/ \\___/_/\\_\\");
        System.out.println();
        System.out.println("A simple script box. Enter JavaScript below.");
        System.out.println("End your input with 'EOF' on a new line.");
        System.out.println("─────────────────────────────────────────────────");
        System.out.flush();

        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder script = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            if ("EOF".equals(line)) break;
            if (script.length() + line.length() > MAX_SCRIPT_SIZE) {
                System.out.println("Error: script too large (max 1MB)");
                return;
            }
            script.append(line).append("\n");
        }

        if (script.isEmpty()) {
            System.out.println("Error: empty script");
            return;
        }

        System.out.println("─────────────────────────────────────────────────");
        System.out.println("[*] Executing...");
        System.out.flush();

        V8 v8 = V8.createV8Runtime();
        v8.registerJavaMethod((JavaVoidCallback) (receiver, params) -> {
            if (params.length() > 0) {
                System.out.println(params.get(0).toString());
                System.out.flush();
            }
        }, "log");

        try {
            Object result = v8.executeScript(script.toString());
            if (result instanceof V8Object) ((V8Object) result).release();
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            if (!v8.isReleased()) v8.release();
        }
    }
}
