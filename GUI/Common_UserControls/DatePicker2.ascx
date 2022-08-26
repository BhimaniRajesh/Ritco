<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DatePicker2.ascx.cs" Inherits="GUI_Common_UserControls_DatePicker2" %>
<%@ Import Namespace="WebX.Common" %>
<%@ Import Namespace="WebX.Common" %>
<script type="text/javascript">
    $(document).ready(function () {
        var currentDate = '<%=DateTime.Now.ToString("dd/MM/yyyy")%>';
        var DtFormat = '<%= ConfigHelper.JSDateFormat %>';
        var DtImg = '<%= ResolveClientUrl("~/GUI/images/calendar.png") %>';
        dtDatePicker = $('#<%= txtDate.ClientID %>');
        //dtDatePicker.val(currentDate.toString('<%= ConfigHelper.DateFormat %>'));
        //LoadOnCallBack($('#<%= txtDate.ClientID %>'));
        LoadOnCallBack1(dtDatePicker, DtFormat, '<%= AllowFutureDate %>', '<%= AllowPastDate %>', DtImg, currentDate, '<%= ConfigHelper.DateFormat %>');
    });
    function LoadOnCallBack1(ObjID, DtFormat, IsFutureDt, IsPastDt, DtImg, systemDate, sysDateFormat) {
        var currentDate = '<%=DateTime.Now.ToString("dd/MM/yyyy")%>';
        ObjID.datepicker({
            //defaultDate: "-1m",
            dateFormat: DtFormat,
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 1,
            showOn: "both",
            buttonImage: '<%= ResolveClientUrl("~/images/calendar.jpg") %>',
            buttonImageOnly: true,
            maxDate: ((IsFutureDt != 'True') ? currentDate : null),
            minDate: ((IsPastDt != 'True') ? currentDate : null),
            onClose: function () {
                this.focus();
            }
        });
    }
    function checkDate(txtDate, allowFutureDate, allowPastDate) {
        var DtFormat = '<%= ConfigHelper.DateFormat %>';
        chkDatePickerDtTT(txtDate, DtFormat, allowFutureDate, allowPastDate);
    }

    function disableDatepicker() {
        dtDatePicker.datepicker("disable");
    }  
</script>
<asp:TextBox runat="server" ID="txtDate" class="input-small" ></asp:TextBox>