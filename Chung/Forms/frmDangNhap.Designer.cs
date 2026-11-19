namespace Chung.Forms
{
    partial class frmDangNhap
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.txtTenDangNhap = new System.Windows.Forms.TextBox();
            this.txtMatKhau = new System.Windows.Forms.TextBox();
            this.lblDangNhap = new System.Windows.Forms.Label();
            this.lblMatKhau = new System.Windows.Forms.Label();
            this.chkHienMK = new System.Windows.Forms.CheckBox();
            this.btnDangNhap = new System.Windows.Forms.Button();
            this.btnThoat = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.linkDangKy = new System.Windows.Forms.LinkLabel();
            this.lblLoi = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(167, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(106, 24);
            this.label1.TabIndex = 0;
            this.label1.Text = "Đăng Nhập";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // txtTenDangNhap
            // 
            this.txtTenDangNhap.Location = new System.Drawing.Point(171, 64);
            this.txtTenDangNhap.Name = "txtTenDangNhap";
            this.txtTenDangNhap.Size = new System.Drawing.Size(102, 20);
            this.txtTenDangNhap.TabIndex = 1;
            // 
            // txtMatKhau
            // 
            this.txtMatKhau.Location = new System.Drawing.Point(171, 102);
            this.txtMatKhau.Name = "txtMatKhau";
            this.txtMatKhau.Size = new System.Drawing.Size(102, 20);
            this.txtMatKhau.TabIndex = 2;
            this.txtMatKhau.UseSystemPasswordChar = true;
            // 
            // lblDangNhap
            // 
            this.lblDangNhap.AutoSize = true;
            this.lblDangNhap.Location = new System.Drawing.Point(65, 64);
            this.lblDangNhap.Name = "lblDangNhap";
            this.lblDangNhap.Size = new System.Drawing.Size(84, 13);
            this.lblDangNhap.TabIndex = 3;
            this.lblDangNhap.Text = "Tên Đăng Nhập";
            // 
            // lblMatKhau
            // 
            this.lblMatKhau.AutoSize = true;
            this.lblMatKhau.Location = new System.Drawing.Point(65, 109);
            this.lblMatKhau.Name = "lblMatKhau";
            this.lblMatKhau.Size = new System.Drawing.Size(53, 13);
            this.lblMatKhau.TabIndex = 4;
            this.lblMatKhau.Text = "Mật Khẩu";
            // 
            // chkHienMK
            // 
            this.chkHienMK.AutoSize = true;
            this.chkHienMK.Location = new System.Drawing.Point(171, 141);
            this.chkHienMK.Name = "chkHienMK";
            this.chkHienMK.Size = new System.Drawing.Size(95, 17);
            this.chkHienMK.TabIndex = 5;
            this.chkHienMK.Text = "Hiện mật khẩu";
            this.chkHienMK.UseVisualStyleBackColor = true;
            this.chkHienMK.CheckedChanged += new System.EventHandler(this.chkHienMK_CheckedChanged);
            // 
            // btnDangNhap
            // 
            this.btnDangNhap.Location = new System.Drawing.Point(171, 208);
            this.btnDangNhap.Name = "btnDangNhap";
            this.btnDangNhap.Size = new System.Drawing.Size(75, 23);
            this.btnDangNhap.TabIndex = 6;
            this.btnDangNhap.Text = "Đăng Nhập";
            this.btnDangNhap.UseVisualStyleBackColor = true;
            this.btnDangNhap.Click += new System.EventHandler(this.btnDangNhap_Click);
            // 
            // btnThoat
            // 
            this.btnThoat.Location = new System.Drawing.Point(276, 208);
            this.btnThoat.Name = "btnThoat";
            this.btnThoat.Size = new System.Drawing.Size(75, 23);
            this.btnThoat.TabIndex = 7;
            this.btnThoat.Text = "Thoát";
            this.btnThoat.UseVisualStyleBackColor = true;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(122, 258);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(100, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "Chưa có tài khoản?";
            this.label4.Click += new System.EventHandler(this.label4_Click);
            // 
            // linkDangKy
            // 
            this.linkDangKy.AutoSize = true;
            this.linkDangKy.Location = new System.Drawing.Point(219, 258);
            this.linkDangKy.Name = "linkDangKy";
            this.linkDangKy.Size = new System.Drawing.Size(46, 13);
            this.linkDangKy.TabIndex = 9;
            this.linkDangKy.TabStop = true;
            this.linkDangKy.Text = "Đăng kí";
            // 
            // lblLoi
            // 
            this.lblLoi.AutoSize = true;
            this.lblLoi.Location = new System.Drawing.Point(168, 178);
            this.lblLoi.Name = "lblLoi";
            this.lblLoi.Size = new System.Drawing.Size(0, 13);
            this.lblLoi.TabIndex = 10;
            // 
            // frmDangNhap
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(503, 314);
            this.Controls.Add(this.lblLoi);
            this.Controls.Add(this.linkDangKy);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.btnThoat);
            this.Controls.Add(this.btnDangNhap);
            this.Controls.Add(this.chkHienMK);
            this.Controls.Add(this.lblMatKhau);
            this.Controls.Add(this.lblDangNhap);
            this.Controls.Add(this.txtMatKhau);
            this.Controls.Add(this.txtTenDangNhap);
            this.Controls.Add(this.label1);
            this.Name = "frmDangNhap";
            this.Text = "frmDangNhap";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtTenDangNhap;
        private System.Windows.Forms.TextBox txtMatKhau;
        private System.Windows.Forms.Label lblDangNhap;
        private System.Windows.Forms.Label lblMatKhau;
        private System.Windows.Forms.CheckBox chkHienMK;
        private System.Windows.Forms.Button btnDangNhap;
        private System.Windows.Forms.Button btnThoat;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.LinkLabel linkDangKy;
        private System.Windows.Forms.Label lblLoi;
    }
}