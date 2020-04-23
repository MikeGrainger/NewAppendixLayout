namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tmptblWork")]
    public partial class tmptblWork
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PPGRef { get; set; }

        public int? BDApp { get; set; }

        [StringLength(255)]
        public string AppName { get; set; }

        [StringLength(255)]
        public string AKA { get; set; }

        public byte? Criticality { get; set; }

        public string Description { get; set; }

        public int? NoOfUsers { get; set; }

        [Key]
        [Column(Order = 1)]
        public bool MultiOfficeUse { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool Excel { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool ExcelVBA { get; set; }

        [Key]
        [Column(Order = 4)]
        public bool Word { get; set; }

        [Key]
        [Column(Order = 5)]
        public bool WordVBA { get; set; }

        [Key]
        [Column(Order = 6)]
        public bool AccessApplication { get; set; }

        [Key]
        [Column(Order = 7)]
        public bool AccessVBA { get; set; }

        [Key]
        [Column(Order = 8)]
        public bool VB6 { get; set; }

        [Key]
        [Column(Order = 9)]
        public bool DAOorADO { get; set; }

        [Key]
        [Column(Order = 10)]
        public bool OtherTool { get; set; }

        [StringLength(50)]
        public string Business_Contact { get; set; }

        public DateTime? Closed { get; set; }

        [StringLength(100)]
        public string Directorate { get; set; }

        [StringLength(128)]
        public string Owner { get; set; }

        public DateTime? Received { get; set; }

        [StringLength(10)]
        public string DLocation { get; set; }

        [StringLength(30)]
        public string Practitioner { get; set; }

        [StringLength(24)]
        public string Support { get; set; }

        [StringLength(255)]
        public string Full_Server_Path { get; set; }

        [StringLength(255)]
        public string App_Path { get; set; }

        [StringLength(255)]
        public string Install_Path { get; set; }

        public string Notes { get; set; }

        [StringLength(50)]
        public string DSTest { get; set; }

        public DateTime? DSDate { get; set; }

        public DateTime? LID { get; set; }

        [StringLength(30)]
        public string WorkType { get; set; }

        [Key]
        [Column(Order = 11)]
        public bool CSData { get; set; }

        [Key]
        [Column(Order = 12)]
        public bool PNUsers { get; set; }

        [Key]
        [Column(Order = 13)]
        public bool Standards { get; set; }

        [Column(TypeName = "money")]
        public decimal? Benefits { get; set; }

        public DateTime? EImpDate { get; set; }

        public int? Percentage { get; set; }

        [StringLength(12)]
        public string Status { get; set; }

        [Column(TypeName = "money")]
        public decimal? OneOff { get; set; }

        [StringLength(20)]
        public string ACSCriticality { get; set; }

        [StringLength(20)]
        public string ACSPlatform { get; set; }

        [StringLength(20)]
        public string ACSConTyp { get; set; }
    }
}
