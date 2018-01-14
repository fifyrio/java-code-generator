package ${packageName}.config.database;

import javax.sql.DataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import javax.annotation.Generated;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import javax.annotation.Generated;

@Generated(
    value = {
        "https://github.com/dee1024/sloth",
        "sloth version:1.0"
    },
    comments = "This class is generated by sloth"
)
@Configuration
public class DB {

    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private DBConfig dbConfig;

    @Bean(destroyMethod = "close")
    @Primary
    public DataSource dataSource(){
        HikariConfig hiConfig = new HikariConfig();
        String url = "jdbc:mysql://" + dbConfig.getDBHost() + ":" + dbConfig.getDBPort() + "/" + dbConfig.getDBName()+"?useUnicode=true&cautoReconnect=true&characterEncoding=utf8";
        hiConfig.setDriverClassName("com.mysql.jdbc.Driver");
        hiConfig.setAutoCommit(true);
        hiConfig.setJdbcUrl(url);
        hiConfig.setUsername(dbConfig.getDBUser());
        hiConfig.setPassword(dbConfig.getDBPassword());
        DataSource dataSource = new HikariDataSource(hiConfig);
        log.info(">>>>dataSource init success:" + dataSource + "[jdbc:mysql://" + dbConfig.getDBHost() + ":" + dbConfig.getDBPort() + "/" + dbConfig.getDBName()+"]");
        return dataSource;
    }


    @Bean(name = "jdbcTemplate")
    @Primary
    JdbcTemplate jdbcTemplate(){
        return new JdbcTemplate(dataSource());
    }


}