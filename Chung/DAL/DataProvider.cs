using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class DataProvider
{
    private static string connStr =
        ConfigurationManager.ConnectionStrings["QLKS"].ConnectionString;

    // SELECT, trả về bảng
    public static DataTable ExecuteQuery(string sql, params SqlParameter[] ps)
    {
        using (var conn = new SqlConnection(connStr))
        using (var cmd = new SqlCommand(sql, conn))
        {
            if (ps != null) cmd.Parameters.AddRange(ps);
            var dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
    }

    // INSERT / UPDATE / DELETE, trả về số dòng bị ảnh hưởng
    public static int ExecuteNonQuery(string sql, params SqlParameter[] ps)
    {
        using (var conn = new SqlConnection(connStr))
        using (var cmd = new SqlCommand(sql, conn))
        {
            if (ps != null) cmd.Parameters.AddRange(ps);
            conn.Open();
            return cmd.ExecuteNonQuery();
        }
    }

    // Lấy một giá trị (COUNT, SUM, ...)
    public static object ExecuteScalar(string sql, params SqlParameter[] ps)
    {
        using (var conn = new SqlConnection(connStr))
        using (var cmd = new SqlCommand(sql, conn))
        {
            if (ps != null) cmd.Parameters.AddRange(ps);
            conn.Open();
            return cmd.ExecuteScalar();
        }
    }
}