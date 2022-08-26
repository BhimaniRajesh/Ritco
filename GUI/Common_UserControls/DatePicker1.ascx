<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DatePicker1.ascx.cs" Inherits="WebX.CommonControls.DatePicker" %>
<%@ Import Namespace="WebX.Common" %>
<script type="text/javascript">
    $(document).ready(function () {
        var currentDate = '<%=DateTime.Now.ToString("dd/MM/yyyy")%>';
        var DtFormat = '<%= ConfigHelper.JSDateFormat %>';
        dtDatePicker = $('#<%= txtDate.ClientID %>');
        //dtDatePicker.val(currentDate.toString('<%= ConfigHelper.DateFormat %>'));
        LoadOnCallBack($('#<%= txtDate.ClientID %>'));

    });

    function LoadOnCallBack(ObjID) {
        var currentDate = '<%=DateTime.Now.ToString("dd/MM/yyyy")%>';
        var DtFormat = '<%= ConfigHelper.JSDateFormat %>';
        ObjID.datepicker({
            defaultDate: "+1w",
            dateFormat: "<%= ConfigHelper.JSDateFormat %>",
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 1,
            showOn: "both",
            buttonImage: '<%= ResolveClientUrl("~/images/calendar.jpg") %>',
            buttonImageOnly: true,
            maxDate: (('<%= AllowFutureDate %>' != 'True') ? currentDate : null),
            minDate: (('<%= AllowPastDate %>' != 'True') ? currentDate : null)
        });
    }

    function checkDate(txtDate, allowFutureDate, allowPastDate) {
        var DtFormat = '<%= ConfigHelper.DateFormat %>';
        chkDatePickerDt11(txtDate, DtFormat, allowFutureDate, allowPastDate);
    }

    function disableDatepicker() {
        dtDatePicker.datepicker("disable");
    }

    <%-- function checkDate(txtDate, allowFutureDate, allowPastDate) {
        try {
            var DtFormat = '<%= ConfigHelper.DateFormat %>'

            if (txtDate.value == "")
                return;

            var selectedDate = Date.parseExact(txtDate.value, 'dd/MM/yyyy');
            var currentDate = Date.today();

            var i = selectedDate.compareTo(currentDate);
            if (i > 0 && '<%= AllowFutureDate %>' == 'False') {
                txtDate.focus();
                alert("Future Date is not allowed");
                return;
            }

            if (i < 0 && '<%= AllowPastDate %>' == 'False') {
                txtDate.focus();
                alert("Past Date is not allowed");
                return;
            }
        } catch (e) {
            txtDate.focus();
            alert(e);
        }
    }--%>
</script>
<asp:TextBox runat="server" ID="txtDate" class="input-small" ></asp:TextBox>