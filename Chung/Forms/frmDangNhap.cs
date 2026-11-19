using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using Chung.Helpers;

namespace Chung.Forms
{
    public partial class frmDangNhap : Form
    {
        int solansai = 0;
        public frmDangNhap()
        {
            InitializeComponent();
        }
        private void chkHienMK_CheckedChanged(object sender, EventArgs e)
        {
            txtMatKhau.UseSystemPasswordChar = !chkHienMK.Checked;
        }
        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string user = txtTenDangNhap.Text.Trim();
            string hash = MatKhauHelper.Hash(txtMatKhau.Text);
            DataTable dt = DataProvider.ExecuteQuery(
                "select TenDangNhap, HoTen, Quyen from nguoidung " +
                "where TenDangNhap = @u and MatKhau = @p and TrangThai = 1",
                new SqlParameter("@u", user),
                new SqlParameter("@p", hash));
            if (dt.Rows.Count == 1)
            {
                PhienDangNhap.TenDangNhap = dt.Rows[0]["TenDangNhap"].ToString();
                PhienDangNhap.HoTen = dt.Rows[0]["HoTen"].ToString();
                PhienDangNhap.Quyen = dt.Rows[0]["Quyen"].ToString();
                this.Hide();
                new frmMain().ShowDialog();
                this.Close();
                return;
            }
            solansai++;
            lblLoi.Text = "Tên đăng nhập hoặc mật khẩu không đúng!(" + solansai + "/3)";
            if (solansai >= 3)
            {
                MessageBox.Show("Bạn đã nhập sai quá 3 lần, chương trình sẽ thoát!");
                Application.Exit();
            }
        }
        private void btnThoat_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void linkDangKy_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            new frmDangKy().ShowDialog();
        }
        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
