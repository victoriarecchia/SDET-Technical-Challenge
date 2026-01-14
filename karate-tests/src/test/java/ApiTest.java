import com.intuit.karate.junit5.Karate;

class ApiTest {
    @Karate.Test
    Karate testAll() {
        // Esto ejecutará todos los archivos .feature en la carpeta 'api'
        return Karate.run().relativeTo(getClass());
    }
}