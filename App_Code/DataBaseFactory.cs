using System.Configuration;
using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public class DataBaseFactory
    {
        #region Protected Members

        protected string ConnString;
        protected SqlConnection SqlConn;
        protected SqlTransaction SqlTrn;
        protected bool IsTransactionBegin = false, IsTransactionRollback = false, IsTransactionCommit = false;

        #endregion Protected Members

        #region Public Properties

        /// <summary>
        /// Get or Set DataBase Connection String
        /// </summary>
        public string ConnectionString { get { return SqlConn.ConnectionString; } set { SqlConn.ConnectionString = value; } }

        #endregion Public Properties

        #region Constructors

        /// <summary>
        /// Create Data Provider Object
        /// </summary>
        /// <param name="connectionString">Database Connection String</param>
        public DataBaseFactory(string connectionString)
        {
            ConnString = connectionString;
            SqlConn = new SqlConnection(ConnString);
        }

        /// <summary>
        /// Create Data Provider Object
        /// </summary>
        public DataBaseFactory()
        {
            //ConnString = SessionUtilities.ConnectionString;
            this.ConnString = ConfigurationManager.AppSettings["dbConnection"]; 
            SqlConn = new SqlConnection(ConnString);
        }

        #endregion Constructors

        #region Data Controller Methods

        #region Open-Close-Dispose Connection

        /// <summary>
        /// Open Sql Connection
        /// </summary>
        public void Open()
        {
            if (SqlConn != null && SqlConn.State != ConnectionState.Open)
                SqlConn.Open();
        }

        /// <summary>
        /// Close Sql Connection
        /// </summary>
        public void Close()
        {
            if (SqlConn != null && SqlConn.State == ConnectionState.Open)
                SqlConn.Close();
        }

        /// <summary>
        /// Dispose Sql Connection object
        /// </summary>
        public void Dispose()
        {
            if (SqlConn != null)
                SqlConn.Dispose();
        }

        #endregion Open-Close-Dispose Connection

        #region Begin-Rollback-Commit Transaction

        /// <summary>
        /// Begin Sql Transaction
        /// </summary>
        /// <returns>SqlTransaction object</returns>
        public SqlTransaction BeginTransaction()
        {
            return BeginTransaction("");
        }

        /// <summary>
        /// Begin Named Sql Transaction
        /// </summary>
        /// <param name="transactionName">Transaction Name</param>
        /// <returns>SqlTransaction object</returns>
        public SqlTransaction BeginTransaction(string transactionName)
        {
            if (SqlConn.State != ConnectionState.Open)
                SqlConn.Open();
            if (!IsTransactionBegin)
                SqlTrn = transactionName != "" ? SqlConn.BeginTransaction(transactionName) : SqlConn.BeginTransaction();

            IsTransactionRollback = false;
            IsTransactionBegin = true;
            IsTransactionCommit = false;
            return SqlTrn;
        }

        /// <summary>
        /// Rollback Sql Transaction
        /// </summary>
        public void RollBackTransaction()
        {
            RollBackTransaction("");
        }

        /// <summary>
        /// Rollback Named Sql Transaction
        /// </summary>
        /// <param name="transactionName">Transaction Name</param>
        public void RollBackTransaction(string transactionName)
        {
            if (SqlConn.State == ConnectionState.Open)
            {
                if (transactionName != "")
                    SqlTrn.Rollback(transactionName);
                else
                    SqlTrn.Rollback();

                IsTransactionRollback = true;
                IsTransactionBegin = false;
                IsTransactionCommit = false;
                SqlConn.Close();
            }
        }

        /// <summary>
        /// Commit Sql Transaction and Close Connection
        /// </summary>
        public void CommitTransaction()
        {
            if (SqlConn.State == ConnectionState.Open)
            {
                SqlTrn.Commit();
                IsTransactionRollback = false;
                IsTransactionBegin = false;
                IsTransactionCommit = true;
                SqlConn.Close();
            }
        }

        #endregion Begin-Rollback-Commit Transaction

        #region DataBind
        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        public void DataBind(Control ctrl, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            if (ctrl.GetType() == typeof(DataList))
            {
                var dl = ctrl as DataList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(GridView))
            {
                var dl = ctrl as GridView;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(Repeater))
            {
                var dl = ctrl as Repeater;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(DropDownList))
            {
                var dl = ctrl as DropDownList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(RadioButtonList))
            {   
                var dl = ctrl as RadioButtonList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(CheckBoxList))
            {
                var dl = ctrl as CheckBoxList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(DataGrid))
            {
                var dl = ctrl as DataGrid;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(ConnString, cmdType, commandText);
                    dl.DataBind();
                }
            }
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="trn">Sql Transaction object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        public void DataBind(Control ctrl, SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            if (ctrl.GetType() == typeof(DataList))
            {
                var dl = ctrl as DataList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(GridView))
            {
                var dl = ctrl as GridView;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(Repeater))
            {
                var dl = ctrl as Repeater;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(DropDownList))
            {
                var dl = ctrl as DropDownList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(RadioButtonList))
            {
                var dl = ctrl as RadioButtonList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(CheckBoxList))
            {
                var dl = ctrl as CheckBoxList;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
            if (ctrl.GetType() == typeof(DataGrid))
            {
                var dl = ctrl as DataGrid;
                if (dl != null)
                {
                    if (cmdType == CommandType.StoredProcedure)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
                    if (cmdType == CommandType.Text)
                        dl.DataSource = SqlHelper.ExecuteDataset(trn, cmdType, commandText);
                    dl.DataBind();
                }
            }
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        public void DataBind(Control ctrl, CommandType cmdType, string commandText)
        {
            DataBind(ctrl, cmdType, commandText, new SqlParameter[0]);
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="trn">Sql Transaction object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>        
        public void DataBind(Control ctrl, SqlTransaction trn, CommandType cmdType, string commandText)
        {
            DataBind(ctrl, trn, cmdType, commandText, new SqlParameter[0]);
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        public void DataBind(Control ctrl, string commandText, SqlParameter[] sqlParamers)
        {
            DataBind(ctrl, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="commandText">Command Text</param>
        public void DataBind(Control ctrl, string commandText)
        {
            DataBind(ctrl, CommandType.Text, commandText, new SqlParameter[0]);
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="trn">Sql Transaction object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        public void DataBind(Control ctrl, SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            DataBind(ctrl, trn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Bind Data to control
        /// </summary>
        /// <param name="ctrl">Control to bind [ Supported Controls: DataList,GridView,DataGrid,Repeater,DropDownList,RadioButtonList,CheckBoxList ]</param>
        /// <param name="trn">Sql Transaction object</param>
        /// <param name="commandText">Command Text</param>
        public void DataBind(Control ctrl, SqlTransaction trn, string commandText)
        {
            DataBind(ctrl, trn, CommandType.Text, commandText, new SqlParameter[0]);
        }

        #endregion DataBind

        #region ExecuteDataSet

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers)
                : SqlHelper.ExecuteDataset(SqlTrn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteDataset(ConnString, CommandType.StoredProcedure, commandText, sqlParamers)
                : SqlHelper.ExecuteDataset(SqlTrn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(string commandText)
        {
            return SqlHelper.ExecuteDataset(ConnString, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(SqlTransaction trn, string commandText)
        {
            return SqlHelper.ExecuteDataset(trn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteDataset(conn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteDataset(conn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute DataSet
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>DataSet object</returns>
        public DataSet ExecuteDataSet(SqlConnection conn, string commandText)
        {
            return SqlHelper.ExecuteDataset(conn, CommandType.Text, commandText);
        }

        #endregion ExecuteDataSet

        #region ExecuteScalar

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>object</returns>
        public object ExecuteScalar(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin 
                ? SqlHelper.ExecuteScalar(ConnString, cmdType, commandText, sqlParamers) 
                : SqlHelper.ExecuteScalar(SqlTrn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>object</returns>
        public object ExecuteScalar(string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin 
                ? SqlHelper.ExecuteScalar(ConnString, CommandType.StoredProcedure, commandText, sqlParamers) 
                : SqlHelper.ExecuteScalar(SqlTrn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>object</returns>
        public object ExecuteScalar(string commandText)
        {
            return !IsTransactionBegin 
                ? SqlHelper.ExecuteScalar(ConnString, CommandType.Text, commandText) 
                : SqlHelper.ExecuteScalar(SqlTrn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>object</returns>
        public object ExecuteScalar(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteScalar(trn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>object</returns>
        public object ExecuteScalar(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>object</returns>
        public object ExecuteScalar(SqlTransaction trn, string commandText)
        {
            return SqlHelper.ExecuteScalar(trn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public object ExecuteScalar(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteScalar(conn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>object</returns>
        public object ExecuteScalar(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteScalar(conn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Scalar
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>object</returns>
        public object ExecuteScalar(SqlConnection conn, string commandText)
        {
            return SqlHelper.ExecuteScalar(conn, CommandType.Text, commandText);
        }

        #endregion ExecuteScalar

        #region ExecuteDataTable

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = new DataTable();
            var ds = !IsTransactionBegin
                ? SqlHelper.ExecuteDataset(ConnString, cmdType, commandText, sqlParamers)
                : SqlHelper.ExecuteDataset(SqlTrn, cmdType, commandText, sqlParamers);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(string commandText, SqlParameter[] sqlParamers)
        {
            var dt = new DataTable();
            var ds = !IsTransactionBegin
                ? SqlHelper.ExecuteDataset(ConnString, CommandType.StoredProcedure, commandText, sqlParamers)
                : SqlHelper.ExecuteDataset(SqlTrn, CommandType.StoredProcedure, commandText, sqlParamers);

            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(string commandText)
        {
            var dt = new DataTable();
            var ds = !IsTransactionBegin
                ? SqlHelper.ExecuteDataset(ConnString, CommandType.Text, commandText)
                : SqlHelper.ExecuteDataset(SqlTrn, CommandType.Text, commandText);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = new DataTable();
            var ds = SqlHelper.ExecuteDataset(trn, cmdType, commandText, sqlParamers);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = new DataTable();
            var ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, commandText, sqlParamers);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(SqlTransaction trn, string commandText)
        {
            var dt = new DataTable();
            var ds = SqlHelper.ExecuteDataset(trn, CommandType.Text, commandText);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = new DataTable();
            var ds = SqlHelper.ExecuteDataset(conn, cmdType, commandText, sqlParamers);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = new DataTable();
            var ds = SqlHelper.ExecuteDataset(conn, CommandType.StoredProcedure, commandText, sqlParamers);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        /// <summary>
        /// Execute DataTable
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>DataTable object</returns>
        public DataTable ExecuteDataTable(SqlConnection conn, string commandText)
        {
            var dt = new DataTable();
            var ds = SqlHelper.ExecuteDataset(conn, CommandType.Text, commandText);
            if (ds.Tables.Count > 0)
                dt = ds.Tables[0];
            return dt;
        }

        #endregion ExecuteDataTable

        #region ExecuteNonQuery

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin 
                ? SqlHelper.ExecuteNonQuery(ConnString, cmdType, commandText, sqlParamers) 
                : SqlHelper.ExecuteNonQuery(SqlTrn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteNonQuery(ConnString, CommandType.StoredProcedure, commandText, sqlParamers)
                : SqlHelper.ExecuteNonQuery(SqlTrn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(string commandText)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteNonQuery(ConnString, CommandType.Text, commandText)
                : SqlHelper.ExecuteNonQuery(SqlTrn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteNonQuery(trn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(SqlTransaction trn, string commandText)
        {
            return SqlHelper.ExecuteNonQuery(trn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteNonQuery(conn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute NonQuery
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>No of records affected</returns>
        public int ExecuteNonQuery(SqlConnection conn, string commandText)
        {
            return SqlHelper.ExecuteNonQuery(conn, CommandType.Text, commandText);
        }

        #endregion ExecuteNonQuery

        #region ExecuteReader

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteReader(ConnString, cmdType, commandText, sqlParamers)
                : SqlHelper.ExecuteReader(SqlTrn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(string commandText, SqlParameter[] sqlParamers)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteReader(ConnString, CommandType.StoredProcedure, commandText, sqlParamers)
                : SqlHelper.ExecuteReader(SqlTrn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(string commandText)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteReader(ConnString, CommandType.Text, commandText)
                : SqlHelper.ExecuteReader(SqlTrn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(string commandText,CommandType cmdType)
        {
            return !IsTransactionBegin
                ? SqlHelper.ExecuteReader(ConnString, cmdType, commandText)
                : SqlHelper.ExecuteReader(SqlTrn, cmdType, commandText);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteReader(trn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteReader(trn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(SqlTransaction trn, string commandText)
        {
            return SqlHelper.ExecuteReader(trn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteReader(conn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteReader(conn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute Reader
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>SqlDataReader object</returns>
        public SqlDataReader ExecuteReader(SqlConnection conn, string commandText)
        {
            return SqlHelper.ExecuteReader(conn, CommandType.Text, commandText);
        }

        #endregion ExecuteReader

        #region ExecuteXmlReader

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteXmlReader(SqlTrn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteXmlReader(SqlTrn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(string commandText)
        {
            return SqlHelper.ExecuteXmlReader(SqlTrn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(SqlTransaction trn, string commandText)
        {
            return SqlHelper.ExecuteXmlReader(trn, CommandType.Text, commandText);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteXmlReader(trn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteXmlReader(trn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteXmlReader(conn, CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            return SqlHelper.ExecuteXmlReader(conn, cmdType, commandText, sqlParamers);
        }

        /// <summary>
        /// Execute XmlReader
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>XmlReader object</returns>
        public XmlReader ExecuteXmlReader(SqlConnection conn, string commandText)
        {
            return SqlHelper.ExecuteXmlReader(conn, CommandType.Text, commandText);
        }

        #endregion ExecuteXmlReader

        #region HasRecord

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = !IsTransactionBegin
                ? ExecuteDataTable(cmdType, commandText, sqlParamers)
                : ExecuteDataTable(SqlTrn, cmdType, commandText, sqlParamers);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(string commandText, SqlParameter[] sqlParamers)
        {
            return HasRecord(CommandType.StoredProcedure, commandText, sqlParamers);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="commandText">Command Text</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(string commandText)
        {
            var dt = !IsTransactionBegin
                ? ExecuteDataTable(commandText)
                : ExecuteDataTable(SqlTrn, commandText);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(SqlTransaction trn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = ExecuteDataTable(trn, cmdType, commandText, sqlParamers);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(SqlTransaction trn, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = ExecuteDataTable(trn, commandText, sqlParamers);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(SqlTransaction trn, string commandText)
        {
            var dt = ExecuteDataTable(trn, commandText);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="cmdType">Command Type : Store Procedure or Text</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(SqlConnection conn, CommandType cmdType, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = ExecuteDataTable(conn, cmdType, commandText, sqlParamers);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <param name="sqlParamers">Parameters List</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(SqlConnection conn, string commandText, SqlParameter[] sqlParamers)
        {
            var dt = ExecuteDataTable(conn, commandText, sqlParamers);
            return (dt.Rows.Count > 0);
        }

        /// <summary>
        /// Check Table contains record(s)
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="commandText">Command Text</param>
        /// <returns>True - If Record(s) exists, else False</returns>
        public bool HasRecord(SqlConnection conn, string commandText)
        {
            var dt = ExecuteDataTable(conn, commandText);
            return (dt.Rows.Count > 0);
        }

        #endregion HasRecord

        #region Insert

        /// <summary>
        /// Insert Data to Table
        /// </summary>
        /// <param name="tablename">Name of Table in which data need to be inserted</param>
        /// <param name="values">Fields name and respective value collection</param>
        /// <returns>True - If Inserted Successfully, else False</returns>
        public bool Insert(string tablename, NameValueCollection values)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");

            string strQuery = "INSERT INTO {0} ({1}) VALUES ({2})";

            string columnList = "", valuesList = "";
            foreach (string key in values.Keys)
            {
                columnList += (columnList.Trim() == "") ? key : "," + key;
                valuesList += (valuesList.Trim() == "") ? "'" + values[key] + "'" : "," + "'" + values[key] + "'";
            }
            strQuery = string.Format(strQuery,tablename, columnList, valuesList);
            var recCount = ExecuteNonQuery(strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Insert Data to Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Name of Table in Which Data need to be inserted</param>
        /// <param name="values">Fields name and respective value collection</param>
        /// <returns>True - If Inserted Successfully, else False</returns>
        public bool Insert(SqlConnection conn, string tablename, NameValueCollection values)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");

            string strQuery = "INSERT INTO {0} ({1}) VALUES ({2})";
            string columnList = "", valuesList = "";
            foreach (string key in values.Keys)
            {
                columnList += (columnList.Trim() == "") ? key : "," + key;
                valuesList += (valuesList.Trim() == "") ? "'" + values[key] + "'" : "," + "'" + values[key] + "'";
            }
            strQuery = string.Format(strQuery,tablename, columnList, valuesList);
            var recCount = ExecuteNonQuery(SqlConn, strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Insert Data to Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Name of Table in Which Data need to be inserted</param>
        /// <param name="values">Fields name and respective value collection</param>
        /// <returns>True - If Inserted Successfully, else False</returns>
        public bool Insert(SqlTransaction trn, string tablename, NameValueCollection values)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");

            string strQuery = "INSERT INTO {0} ({1}) VALUES ({2})";
            string columnList = "", valuesList = "";
            foreach (string key in values.Keys)
            {
                columnList += (columnList.Trim() == "") ? key : "," + key;
                valuesList += (valuesList.Trim() == "") ? "'" + values[key] + "'" : "," + "'" + values[key] + "'";
            }
            strQuery = string.Format(strQuery,tablename, columnList, valuesList);
            var recCount = ExecuteNonQuery(trn, strQuery);
            return (recCount > 0);
        }

        #endregion Insert

        #region Update

        /// <summary>
        /// Update Data of Table
        /// </summary>
        /// <param name="tablename">Name of Table in which data need to be updated</param>
        /// <param name="values">Collection fields name with respective value to be updated</param>
        /// <param name="whereParam">Fields name and values to fetch data to be updated</param>
        /// <returns>True - If Updated Successfully, else False</returns>
        public bool Update(string tablename, NameValueCollection values, NameValueCollection whereParam)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");

            string strQuery = "UPDATE {0} SET {1} WHERE {2}";
            string setValue = "", condition = "";
            foreach (string key in values.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, values[key]);
                setValue += (setValue.Trim() == "") ? tmp : "," + tmp;
            }
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery,tablename, setValue, condition);
            var recCount = ExecuteNonQuery(strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Update Data of Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Name of Table in which data need to be updated</param>
        /// <param name="values">Collection fields name with respective value to be updated</param>
        /// <param name="whereParam">Fields name and values to fetch data to be updated</param>
        /// <returns>True - If Updated Successfully, else False</returns>
        public bool Update(SqlConnection conn, string tablename, NameValueCollection values, NameValueCollection whereParam)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");

            string strQuery = "UPDATE {0} SET {1} WHERE {2}";
            string setValue = "", condition = "";
            foreach (string key in values.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, values[key]);
                setValue += (setValue.Trim() == "") ? tmp : "," + tmp;
            }
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery,tablename, setValue, condition);
            int recCount = ExecuteNonQuery(conn, strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Update Data of Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Name of Table in which data need to be updated</param>
        /// <param name="values">Collection fields name with respective value to be updated</param>
        /// <param name="whereParam">Fields name and values to fetch data to be updated</param>
        /// <returns>True - If Updated Successfully, else False</returns>
        public bool Update(SqlTransaction trn, string tablename, NameValueCollection values, NameValueCollection whereParam)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");

            string strQuery = "UPDATE {0} SET {1} WHERE {2}";
            string setValue = "", condition = "";
            foreach (string key in values.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, values[key]);
                setValue += (setValue.Trim() == "") ? tmp : "," + tmp;
            }
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery,tablename, setValue, condition);
            int recCount = ExecuteNonQuery(trn, strQuery);
            return (recCount > 0);
        }

        #endregion Update

        #region GetData

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnList">Coma(,) separated list of Columns to be Selected</param>
        /// <param name="whereParam">Fields name and value to fetch data</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(string tablename, string columnList, NameValueCollection whereParam)
        {
            string strQuery = "SELECT {0} FROM {1}";
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            string condition = "";
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery,columnList, tablename);
            if (!String.IsNullOrEmpty(condition.Trim()))
                strQuery += string.Format(" WHERE {0}", condition);

            return ExecuteDataTable(strQuery);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnList">Coma(,) separated list of Columns to be Selected</param>
        /// <param name="whereParam">Fields name and value to fetch data</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(SqlConnection conn, string tablename, string columnList, NameValueCollection whereParam)
        {
            string strQuery = "SELECT {0} FROM {1}";
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            string condition = "";
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery,columnList, tablename);
            if (!String.IsNullOrEmpty(condition.Trim()))
                strQuery += string.Format(" WHERE {0}", condition);

            return ExecuteDataTable(conn, strQuery);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnList">Coma(,) separated list of Columns to be Selected</param>
        /// <param name="whereParam">Fields name and value to fetch data</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(SqlTransaction trn, string tablename, string columnList, NameValueCollection whereParam)
        {
            string strQuery = "SELECT {0} FROM {1}";
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            string condition = "";
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery,columnList, tablename);
            if (!String.IsNullOrEmpty(condition.Trim()))
                strQuery += string.Format(" WHERE {0}", condition);

            return ExecuteDataTable(trn, strQuery);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnsArray">Non-Generic Collection(Array) of Columns to be Selected</param>
        /// <param name="whereParam">Fields name and value to fetch data</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(string tablename, IList columnsArray, NameValueCollection whereParam)
        {
            return GetData(tablename, StringFunctions.StringBuilderProcessing.ArrayToString(columnsArray, ","), whereParam);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnsArray">Non-Generic Collection(Array) of Columns to be Selected</param>
        /// <param name="whereParam">Fields name and value to fetch data</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(SqlConnection conn, string tablename, IList columnsArray, NameValueCollection whereParam)
        {
            return GetData(conn, tablename, StringFunctions.StringBuilderProcessing.ArrayToString(columnsArray, ","), whereParam);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnsArray">Non-Generic Collection(Array) of Columns to be Selected</param>
        /// <param name="whereParam">Fields name and value to fetch data</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(SqlTransaction trn, string tablename, IList columnsArray, NameValueCollection whereParam)
        {
            return GetData(trn, tablename, StringFunctions.StringBuilderProcessing.ArrayToString(columnsArray, ","), whereParam);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnList">Coma(,) separated list of Columns to be Selected</param>
        /// <param name="whereClause">Where Clause to filter records</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(string tablename, string columnList, string whereClause)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            if (whereClause.Trim() == "")
                throw new Exception("WhareClose can not be blank");

            string strQuery = "SELECT {0} FROM {1}";
            strQuery = string.Format(strQuery,columnList, tablename);
            if (!String.IsNullOrEmpty(whereClause.Trim()))
                strQuery += string.Format(" WHERE {0}", whereClause);

            return ExecuteDataTable(strQuery);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnList">Coma(,) separated list of Columns to be Selected</param>
        /// <param name="whereClause">Where clause to filter records</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(SqlConnection conn, string tablename, string columnList, string whereClause)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            if (whereClause.Trim() == "")
                throw new Exception("WhareClose can not be blank");

            string strQuery = "SELECT {0} FROM {1}";
            strQuery = string.Format(strQuery,columnList, tablename);
            if (!String.IsNullOrEmpty(whereClause.Trim()))
                strQuery += string.Format(" WHERE {0}", whereClause);

            return ExecuteDataTable(conn, strQuery);
        }

        /// <summary>
        /// Get Data for Specified Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="columnList">Coma(,) separated list of Columns to be Selected</param>
        /// <param name="whereClause">Where clause to filter records</param>
        /// <returns>DataTable object</returns>
        public DataTable GetData(SqlTransaction trn, string tablename, string columnList, string whereClause)
        {
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            if (whereClause.Trim() == "")
                throw new Exception("WhareClose can not be blank");

            string strQuery = "SELECT {0} FROM {1}";
            strQuery = string.Format(strQuery,columnList, tablename);
            if (!String.IsNullOrEmpty(whereClause.Trim()))
                strQuery += string.Format(" WHERE {0}", whereClause);

            return ExecuteDataTable(trn, strQuery);
        }

        #endregion GetData

        #region Delete

        /// <summary>
        /// Delete Records from Specified Table
        /// </summary>
        /// <param name="tablename">Table Name</param>
        /// <param name="whereParam">Fields name and values to fetch data to be deleted</param>
        /// <returns>True -If Deleted Successfully, else False</returns>
        public bool Delete(string tablename, NameValueCollection whereParam)
        {
            string strQuery = "DELETE FROM {0} WHERE {1}";
            string condition = "";
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery, tablename, condition);
            int recCount = ExecuteNonQuery(strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Delete Records from Specified Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="whereParam">Fields name and values to fetch data to be deleted</param>
        /// <returns>True -If Deleted Successfully, else False</returns>
        public bool Delete(SqlConnection conn, string tablename, NameValueCollection whereParam)
        {
            string strQuery = "DELETE FROM {0} WHERE {1}";
            string condition = "";
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery, tablename, condition);
            int recCount = ExecuteNonQuery(conn, strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Delete Records from Specified Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="whereParam">Fields name and values to fetch data to be deleted</param>
        /// <returns>True -If Deleted Successfully, else False</returns>
        public bool Delete(SqlTransaction trn, string tablename, NameValueCollection whereParam)
        {
            string strQuery = "DELETE FROM {0} WHERE {1}";
            string condition = "";
            foreach (string key in whereParam.Keys)
            {
                string tmp = string.Format("{0}='{1}'", key, whereParam[key]);
                condition += (condition.Trim() == "") ? tmp : " AND " + tmp;
            }
            strQuery = string.Format(strQuery, tablename, condition);
            int recCount = ExecuteNonQuery(trn, strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Delete Records from Specified Table
        /// </summary>
        /// <param name="tablename">Table Name</param>
        /// <param name="whereClause">Where Clause to filter records for Delete</param>
        /// <returns>True -If Deleted Successfully, else False</returns>
        public bool Delete(string tablename, string whereClause)
        {
            string strQuery = "DELETE FROM {0} WHERE {1}";
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            if (whereClause.Trim() == "")
                throw new Exception("WhareClose can not be blank");
            strQuery = string.Format(strQuery, tablename, whereClause);
            int recCount = ExecuteNonQuery(strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Delete Records from Specified Table
        /// </summary>
        /// <param name="conn">Sql Connection Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="whereClause">Where Clause to filter records for Delete</param>
        /// <returns>True -If Deleted Successfully, else False</returns>
        public bool Delete(SqlConnection conn, string tablename, string whereClause)
        {
            string strQuery = "DELETE FROM {0} WHERE {1}";
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            if (whereClause.Trim() == "")
                throw new Exception("WhareClose can not be blank");
            strQuery = string.Format(strQuery, tablename, whereClause);
            int recCount = ExecuteNonQuery(conn, strQuery);
            return (recCount > 0);
        }

        /// <summary>
        /// Delete Records from Specified Table
        /// </summary>
        /// <param name="trn">Sql Transaction Object</param>
        /// <param name="tablename">Table Name</param>
        /// <param name="whereClause">Where Clause to filter records for Delete</param>
        /// <returns>True -If Deleted Successfully, else False</returns>
        public bool Delete(SqlTransaction trn, string tablename, string whereClause)
        {
            string strQuery = "DELETE FROM {0} WHERE {1}";
            if (tablename.Trim() == "")
                throw new Exception("TableName can not be blank");
            if (whereClause.Trim() == "")
                throw new Exception("WhareClose can not be blank");
            strQuery = string.Format(strQuery, tablename, whereClause);
            int recCount = ExecuteNonQuery(trn, strQuery);
            return (recCount > 0);
        }

        #endregion Delete

        #endregion Data Controller Methods
    }