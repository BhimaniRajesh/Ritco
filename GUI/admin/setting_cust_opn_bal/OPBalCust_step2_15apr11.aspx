<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="OPBalCust_step2.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_OPBalCust_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
Frmnae="ctl00$MyCPH1$"
 function check_debit_credit1(type)
 {
    
       // var debit1=document.getElementById(Frmnae+"txtDebit1").value
      //  var credit1=document.getElementById(Frmnae+"txtCredit1").value
  // alert("hi....")
      if(type=="C")
            {
                GridId="GV_Customer";
            }
            else if (type=="V")
            {
                GridId="GV_Vendor";
            }
             else if (type=="D")
            {
                GridId="GV_Driver";
            }
            else if (type=="E")
            {
                GridId="GV_Emp";
            }
         var mTotalRecords = "<%=intTotalRecords %>"
       //alert(mTotalRecords)
        for (var i=0; i < mTotalRecords; i++)
        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                           
                                debit1 = document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$TxtDebit").value
                                credit1= document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$TxtCredit").value
                                // alert(credit1)
                                
                            }
                            else
                            {
                                debit1 = document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl" + j + "$TxtDebit").value
                                credit1 = document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl" + j + "$TxtCredit").value
                            }
        
                            if(parseFloat(debit1)>0 && parseFloat(credit1)>0)
                            {
                            alert("Either Debit can be > 0 OR Credit Can be >0 !!!")
                            return false;
                            }
        }
 }

function validInt(event)
{
    if(event.keyCode==13)
        {
            return true;
        }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}
function validFloat(event,txtid)
{
    //var tb=document.getElementById(txtid);
    var txt=txtid.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
}
function checkall(obj,type)
           {
            
           /// alert("hi...")
            if(type=="C")
            {
                GridId="GV_Customer";
            }
            else if (type=="V")
            {
                GridId="GV_Vendor";
            }
             else if (type=="D")
            {
                GridId="GV_Driver";
            }
            else if (type=="E")
            {
                GridId="GV_Emp";
            }
             var mTotalRecords = "<%=intTotalRecords %>"
            
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$Chkcust"
                                
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + j + "$Chkcust"
                               
                            }
                            
                            if(obj.checked==true)
                            {
                            document.getElementById(chk_ind).checked=true;
                            }
                            else
                            {
                             document.getElementById(chk_ind).checked=false;
                            }
                       }
                   
            }
            function checkall_ind(type)
            {
              //alert("hi..")
            if(type=="C")
            {
                GridId="GV_Customer";
            }
            else if (type=="V")
            {
                GridId="GV_Vendor";
            }
             else if (type=="D")
            {
                GridId="GV_Driver";
                
            }
            else if (type=="E")
            {
                GridId="GV_Emp";
            }
                var mTotalRecords = "<%=intTotalRecords %>";
                var chk_cnt=0;
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                            
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + "0" + j + "$Chkcust"
                                
                                //alert(mDerivedControlName)
                                
                            }
                            else
                            {
                                chk_ind = "ctl00$MyCPH1$"+GridId+"$ctl" + j + "$Chkcust"
                               
                            }
                            
                               if(document.getElementById(chk_ind).checked==true)
                               {
                                    chk_cnt=chk_cnt+1
                               }
                                                       
                       }
                        if(parseFloat(chk_cnt)==parseFloat(mTotalRecords))
                        {
                            document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl01$chkall").checked=true
                        }
                        else
                        {
                            document.getElementById("ctl00$MyCPH1$"+GridId+"$ctl01$chkall").checked=false
                        }
                     
            }
    </script>

    <br />
    <div align="left">
        <table border="0" cellspacing="0" cellpadding="2" style="width: 9.5in">
            <tr bgcolor="#FFFFFF">
                <td>
                    <font class="blackfnt"><b><u>Note</u> :</b>&nbsp;Please click on "Submit" button to
                        save changes for that particular page no.</font></td>
            </tr>
        </table>
        <br />
        <asp:Panel ID="p1" runat="server" Visible="false">
            <table border="0" cellspacing="1" cellpadding="3" style="width: 9.5in" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:GridView ID="GV_Customer" runat="server" align="center" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                            BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="false" AllowSorting="False"
                            AutoGenerateColumns="false" PEmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this,'C')" />
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="Chkcust" runat="server" onclick="javascript:checkall_ind('C')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblAcctcode" CssClass="blackfnt" Text='Account Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Acctcode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"acctval") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblCustcode" CssClass="blackfnt" Text='Customer Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Custcode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"custval") %>'></asp:Label>
                                        <asp:HiddenField ID="hnd_Custcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"custcode") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblDebit" CssClass="blackfnt" Text='Debit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtDebit" onkeypress="javascript:return validFloat(event,this)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opendebit") %>' runat="server"
                                            MaxLength="12" Columns="12" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblCredit" CssClass="blackfnt" Text='Credit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtCredit" onkeypress="javascript:return validFloat(event,this)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opencredit") %>' runat="server"
                                            MaxLength="12" Columns="12" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:Button ID="btnSubmit1" runat="server" Text="Submit" OnClick="btnSubmit1_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="p2" runat="server" Visible="false">
            <table border="0" cellspacing="1" cellpadding="3" style="width: 9.5in" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:GridView ID="GV_Vendor" runat="server" align="center" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                            BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="false" AllowSorting="False"
                            AutoGenerateColumns="false" PEmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this,'V')" />
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="Chkcust" runat="server" onclick="javascript:checkall_ind('V')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblAcctcode" CssClass="blackfnt" Text='Account Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Acctcode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"acctval") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblVendorcode" CssClass="blackfnt" Text='Vendor Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Vendorcode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Vendval") %>'></asp:Label>
                                        <asp:HiddenField ID="hnd_Vendorcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VendorCode") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblDebit" CssClass="blackfnt" Text='Debit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtDebit" onkeypress="javascript:return validFloat(event,this)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opendebit") %>' runat="server"
                                            MaxLength="12" Columns="12" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblCredit" CssClass="blackfnt" Text='Credit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtCredit" onkeypress="javascript:return validFloat(event,this)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opencredit") %>' runat="server"
                                            MaxLength="12" Columns="12" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:Button ID="btnSubmit2" runat="server" Text="Submit" OnClick="btnSubmit2_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="P3" runat="server" Visible="false">
            <table border="0" cellspacing="1" cellpadding="3" style="width: 9.5in" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:GridView ID="GV_Driver" runat="server" align="center" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                            BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="false" AllowSorting="False"
                            AutoGenerateColumns="false" PEmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this,'D')" />
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="Chkcust" runat="server" onclick="javascript:checkall_ind('D')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblAcctcode" CssClass="blackfnt" Text='Account Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Acctcode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"acctval") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblVendorcode" CssClass="blackfnt" Text='Driver Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Lbl_Driver" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"drvval") %>'></asp:Label>
                                        <asp:HiddenField ID="hnd_Drivercode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"driver_id") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblDebit" CssClass="blackfnt" Text='Debit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtDebit" onkeypress="javascript:return validFloat(event)" onblur="javascript:this.value=rounditn(this.value,2)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opendebit") %>' runat="server"
                                            MaxLength="10" Columns="8" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblCredit" CssClass="blackfnt" Text='Credit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtCredit" onkeypress="javascript:return validFloat(event)" onblur="javascript:this.value=rounditn(this.value,2)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opencredit") %>' runat="server"
                                            MaxLength="10" Columns="8" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:Button ID="button3" runat="server" Text="Submit" OnClick="btnSubmit3_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="P4" runat="server" Visible="false">
            <table border="0" cellspacing="1" cellpadding="3" style="width: 9.5in" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:GridView ID="GV_Emp" runat="server" align="center" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                            BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="false" AllowSorting="False"
                            AutoGenerateColumns="false" PEmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this,'E')" />
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="Chkcust" runat="server" onclick="javascript:checkall_ind('D')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblAcctcode" CssClass="blackfnt" Text='Account Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Acctcode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"acctval") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblVendorcode" CssClass="blackfnt" Text='Driver Code/Name'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Lbl_Driver" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"drvval") %>'></asp:Label>
                                        <asp:HiddenField ID="hnd_EmpCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"userid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblDebit" CssClass="blackfnt" Text='Debit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtDebit" onkeypress="javascript:return validFloat(event)" onblur="javascript:this.value=rounditn(this.value,2)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opendebit") %>' runat="server"
                                            MaxLength="10" Columns="8" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center>
                                            <asp:Label runat="server" ID="lblCredit" CssClass="blackfnt" Text='Credit'></asp:Label>
                                        </center>
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtCredit" onkeypress="javascript:return validFloat(event)" onblur="javascript:this.value=rounditn(this.value,2)"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"opencredit") %>' runat="server"
                                            MaxLength="10" Columns="8" CssClass="blackfnt"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:Button ID="Btn_Emp" runat="server" Text="Submit" OnClick="btnSubmit4_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>
