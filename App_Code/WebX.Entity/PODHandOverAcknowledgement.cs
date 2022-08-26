using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebX.Entity
{
    public class PODHandOverAcknowledgement
    {
        public string PODNo { get; set; }
        public string DockNo { get; set; }
        public string RejectionRemark { get; set; }
        public bool IsAccept { get; set; }
        public bool IsReject { get; set; }
    }
}