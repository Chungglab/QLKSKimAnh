using System;
using System.Security.Cryptography;
using System.Text;

namespace Chung.Helpers
{
    public static class MatKhauHelper
    {
        // Mã hóa SHA-256, trả về chuỗi hex CHỮ HOA
        public static string Hash(string s)
        {
            using (var sha = SHA256.Create())
            {
                byte[] b = sha.ComputeHash(Encoding.UTF8.GetBytes(s));
                return BitConverter.ToString(b).Replace("-", "");
            }
        }
    }
}