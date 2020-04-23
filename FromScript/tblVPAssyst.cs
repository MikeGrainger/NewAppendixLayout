namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPAssyst")]
    public partial class tblVPAssyst
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Assyst_Reference { get; set; }

        public int BDApp_ID { get; set; }

        [Required]
        [StringLength(100)]
        public string Assyst_Description { get; set; }

        [Column(TypeName = "date")]
        public DateTime Assyst_Open { get; set; }

        public int? Assign_Dev { get; set; }

        [Column(TypeName = "date")]
        public DateTime SLA_Target { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Email_Sent { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Email_Chased { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Assyst_Close { get; set; }

        [StringLength(100)]
        public string Notes { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Next_Action_Date { get; set; }

        [StringLength(100)]
        public string Next_Action { get; set; }

        [StringLength(50)]
        public string Assyst_Fix { get; set; }
    }
}
