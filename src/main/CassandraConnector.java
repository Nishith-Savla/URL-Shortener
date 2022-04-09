import com.datastax.oss.driver.api.core.CqlIdentifier;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.CqlSessionBuilder;

import java.net.InetSocketAddress;

public class CassandraConnector {
    private final String[] nodes;
    private final int[] ports;
    private CqlSession session;

    public CassandraConnector() {
        this.nodes = null;
        this.ports = null;
    }

    public CassandraConnector(String[] nodes, int[] ports) {
        this.nodes = nodes;
        this.ports = ports;
    }

    public CqlSession getSession() {
        return session;
    }

    public boolean connect() {
        return connect(null);
    }

    public boolean connect(String keyspace) {
        try {
            CqlSessionBuilder builder = CqlSession.builder();
            if (nodes != null && ports != null) {
                for (int i = 0; i < nodes.length; ++i) {
                    builder = builder.addContactPoint(new InetSocketAddress(nodes[i], ports[i]));
                }
            }

            if (keyspace != null) {
                builder = builder.withKeyspace(CqlIdentifier.fromCql(keyspace));
            }

            this.session = builder.build();
            return true;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    public void close() {
        this.session.close();
    }
}
