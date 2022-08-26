<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCSelection.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_THCBalanceCancellation_THCSelection" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        
        function check()
            {
                var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");                
              
                if(hdnajaxstate.value!="0")
                {
                    alert("Let the Internal Processes over. Try After 5-10 seconds or LogOut.");
                    return false;
                }
                var mTotalRecords = "<%=intTotalRecords %>"
                var mDerivedControlName = "";
                var mSelection = 0;
                var j = 0;
            var mSelectedDockets = "";
            //alert(mTotalRecords)
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
            
                if(j < 10)
                {
                    mDerivedControlName = "ctl00$MyCPH1$GridTHCList$ctl" + "0" + j + "$chkDock"
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$GridTHCList$ctl" + j + "$chkDock"
                }
                
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one Document ....!");
                return false;
            }

            document.getElementById("ctl00_MyCPH1_txtdocketlist").value=mSelection
            document.getElementById("ctl00_MyCPH1_txtdocketlist_count").value=mSelectedDockets;
         
          
           
          
                              
                return true;   
               
            
             }
                
                
                
                
            function checkVoucherNo(chkid,lblid)
            {
                var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");                
                hdnajaxstate.value="1";
                    var chkyes = document.getElementById(chkid);
                     var voucherno = document.getElementById(lblid).innerText;
                     var findobj=false;
                     
                 
                         findobj=GetXMLHttpObject();
                            if(findobj)
                            {
                                 var strpg="CheckExist.aspx?voucherno=" + voucherno + "&sid=" + Math.random();
                                 findobj.open("GET",strpg);
                                 findobj.onreadystatechange=function()
                                     {
                                         if(findobj.readyState==4 && findobj.status==200)
                                            {
                                                var res=findobj.responseText;
                                                if(res=="false")
                                                {
                                                    alert("Balance Payment Not Done");
                                                    chkyes.checked=false;
                                                    hdnajaxstate.value="0";
                                                }
                                                else
                                                {
                                                    hdnajaxstate.value="0";
                                                }
                                            }
                                     }
                                    findobj.send(null);
                             }return true;
                 }

                 
         
            
       
        
    </script>

    <br />
    <div align="center">
        <form id="form1">
            <div align="left">
                <p align="left">
                    <font class="blackfnt"><b>You Selected</b></font></p>
                <table border="0" cellpadding="3" cols="1" style="width: 7.5in" bgcolor="#808080"
                    cellspacing="1" align="left" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td width="205" align="left">
                            <div align="left">
                                <font class="blackfnt">Document Type</font>
                            </div>
                        </td>
                        <td width="343" align="center">
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocType" runat="server" Text="Label"></asp:Label></font></div>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <p align="left">
                    <font class="blackfnt"><b>Select THC for Balance Cancellation</b></font></p>
                <asp:GridView ID="GridTHCList" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                    AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" OnRowDataBound="GridTHCList_RowDataBound" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found..." Style="width: 7.5in">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <center>
                                    <input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"THCNO") %>' />
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="THC No">
                        <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <center>
                                    <asp:Label ID="lblTHCNO" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"THCNO") %>'></asp:Label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="balanceamount" HeaderText="Balance Amount">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Balance VoucherNo">
                        <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <center>
                                    <asp:Label ID="lblVoucherNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"balvoucherno") %>'></asp:Label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Font-Bold="true"/>
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
            </div>
            <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
            <br />
            <asp:HiddenField ID="txtdocketlist" runat="server" />
            <asp:HiddenField ID="txtdocketlist_count" runat="server" />
            <div align="left">
                <asp:Button ID="Button1" runat="server" CssClass="blackfnt" Text="Submit" OnClientClick="javascript:return check()"
                    OnClick="Button1_Click" />
            </div>
        </form>
    </div>
</asp:Content>
