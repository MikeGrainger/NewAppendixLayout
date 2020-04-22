namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPDetail
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_ID { get; set; }

        [StringLength(50)]
        public string Directorate { get; set; }

        [StringLength(50)]
        public string CGroup { get; set; }

        public bool BDAppReg { get; set; }

        public int? BusinessCriticality { get; set; }

        [StringLength(100)]
        public string ProductOwner { get; set; }

        [StringLength(100)]
        public string BusinessSME { get; set; }

        [StringLength(100)]
        public string BusinessContact { get; set; }

        public int? LeadDeveloper { get; set; }

        [StringLength(100)]
        public string DataGuardian { get; set; }

        public string BDAppDescription { get; set; }

        public string BDAppNotes { get; set; }

        [StringLength(250)]
        public string SQLPreProdLocation { get; set; }

        [StringLength(250)]
        public string SQLLiveLocation { get; set; }

        [StringLength(250)]
        public string BDAppFolder { get; set; }

        [StringLength(50)]
        public string FrontEndLanguage { get; set; }

        [StringLength(50)]
        public string BackEndLanguage { get; set; }
    }
}
