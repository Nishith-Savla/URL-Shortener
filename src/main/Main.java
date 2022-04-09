import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

public class Main {
    public static void main(String[] args) {
        final var connector = new CassandraConnector();
        if (connector.connect("urlshortener")) {
            System.out.println("Connected");
        }

        connector.close();
    }
}
