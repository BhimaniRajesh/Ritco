using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace WebX.Entity
{
    /// <summary>
    /// Summary description for ObjStateMaster
    /// </summary>
    public class State
    {
        #region Variable[s]
        private int _srNo;
        private string _code;
        private string _name;
        private decimal _freightRate;
        private string _freightRateType;
        private string _updateBy;
        private DateTime _updateDate;
        private string _entryBy;
        private DateTime _entryDate;
        private string _activeFlag;
        private string _sTaxFlag;
        private string _stateType;
        private string _stateCode;
        
        #endregion

        #region Constructor
        public State()
        {
            //
            // TODO: Add constructor logic here
            //
            _srNo = 0;
            _code = string.Empty;
            _name = string.Empty;
            _freightRate = 0.0M;
            _freightRateType = string.Empty;
            _updateBy = string.Empty;
            _updateDate = System.DateTime.MinValue;
            _entryBy = string.Empty;
            _entryDate = System.DateTime.MinValue;
            _activeFlag = string.Empty;
            _sTaxFlag = string.Empty;
            _stateType = string.Empty;
            _stateCode = string.Empty;
        }
        #endregion

        #region Property

        // Serial Number
        public int SrNo { get { return _srNo; } set { _srNo = value; } }

        // State Code
        public string Code
        {
            get
            {
                return _code;
            }
            set
            {
                _code = value;
            }
        }

        // State Name
        public string Name
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
            }
        }


        // Active Flag
        public string ActiveFlag
        {
            get
            {
                return _activeFlag;
            }
            set
            {
                _activeFlag = value;
            }
        }

        // Record is updateby Userid : Username
        public string UpdateBy
        {
            get
            {
                return _updateBy;
            }
            set
            {
                _updateBy = value;
            }
        }

        // Record is update on date
        public DateTime UpdateDate
        {
            get
            {
                return _updateDate;
            }
            set
            {
                _updateDate = value;
            }
        }

        // Record is entryby Userid : Username
        public string EntryBy
        {
            get
            {
                return _entryBy;
            }
            set
            {
                _entryBy = value;
            }
        }

        // Record is entry on date
        public DateTime EntryDate
        {
            get
            {
                return _entryDate;
            }
            set
            {
                _entryDate = value;
            }
        }


        // Freight Rate
        public decimal FreightRate
        {
            get
            {
                return _freightRate;
            }
            set
            {
                _freightRate = value;
            }
        }

        // Freight Rate Type
        public string FreightRateType
        {
            get
            {
                return _freightRateType;
            }
            set
            {
                _freightRateType = value;
            }
        }
        public string ServiceTaxFlag
        {
            get
            {
                return _sTaxFlag;
            }
            set
            {
                _sTaxFlag = value;
            }
        }

        public string StateType
        {
            get
            {
                return _stateType;
            }
            set
            {
                _stateType = value;
            }
        }

        public string StateCode
        {
            get
            {
                return _stateCode;
            }
            set
            {
                _stateCode = value;
            }
        }

        
        #endregion
    }

    public class StateDocument
    {
        #region Variable[s]

        private string _code;
        private string _form;
        private string _permit;
        private string _inoutbound;
        private string _stcstreq;
        private string _strem;
        private string _FlagInsert;
        #endregion

        #region Constructor
        public StateDocument()
        {
            //
            // TODO: Add constructor logic here
            //
            _code = string.Empty;
            _form = string.Empty;
            _permit = string.Empty;
            _inoutbound = string.Empty;
            _stcstreq = string.Empty;
            _strem = string.Empty;
        }
        #endregion

        #region Property
        // State Code
        public string Code
        {
            get
            {
                return _code;
            }
            set
            {
                _code = value;
            }
        }
        // State Form
        public string Form
        {
            get
            {
                return _form;
            }
            set
            {
                _form = value;
            }
        }
        // State Permit
        public string Permit
        {
            get
            {
                return _permit;
            }
            set
            {
                _permit = value;
            }
        }
        // State Inout Bound
        public string InOutBound
        {
            get
            {
                return _inoutbound;
            }
            set
            {
                _inoutbound = value;
            }
        }
        //
        public string Require
        {
            get
            {
                return _stcstreq;
            }
            set
            {
                _stcstreq = value;
            }
        }
        //
        public string Strem
        {
            get
            {
                return _strem;
            }
            set
            {
                _strem = value;
            }
        }

        public string FlagInsert
        {
            get
            {
                return _FlagInsert;
            }
            set
            {
                _FlagInsert = value;
            }
        }

        #endregion


    }

}
