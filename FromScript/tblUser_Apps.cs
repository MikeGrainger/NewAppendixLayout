namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblUser_Apps
    {
        [Key]
        public int User_App_ID { get; set; }

        public int PID { get; set; }

        public int BDApp_ID { get; set; }

        public bool Favourite_App { get; set; }

        [Column(TypeName = "date")]
        public DateTime Last_Used_by_User { get; set; }

        public virtual tblApplication tblApplication { get; set; }

        public virtual tblUser tblUser { get; set; }
    }
}
