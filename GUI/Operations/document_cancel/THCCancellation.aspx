<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCCancellation.aspx.cs" Inherits="GUI_Operations_document_cancel_THCCancellation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../GUI/images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
        
            function THCBlur(d)
                 {
                 
                    var txtTHC=d;
                    var txtFrom=d;
                    var txtTo=d;
                    var txtDate=d;
                    var txtManualno=d;
                    txtFrom=txtFrom.replace( "txtTHCNo", "lblFrom");
                    document.getElementById("ctl00_MyCPH1_hidFrom").value=txtFrom;
                    txtTo=txtTo.replace( "txtTHCNo", "lblTo");
                    document.getElementById("ctl00_MyCPH1_hidTo").value=txtTo;
                    txtDate=txtDate.replace( "txtTHCNo", "lblTHCDate");
                    document.getElementById("ctl00_MyCPH1_hidDate").value=txtDate;
                    txtManualno=txtManualno.replace( "txtTHCNo", "lblManualTHCNo");
                    document.getElementById("ctl00_MyCPH1_hidManualNo").value=txtManualno;
              
                    var str="";
                    for(var i=0;i<d.length-10;i++)
                    {
                        str+=d.charAt(i);
                    }
                    
                    var txtTHCNo=document.getElementById(d);
                  
                    var THCNo=txtTHCNo.value;
                    if(THCNo=="")
                        return false;
                 
                   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
                   var r=tbl.rows.length;
                   
                    var findobj=false;
                    findobj=GetXMLHttpObject();
                    if(findobj)
                    {
                     var strpg="CheckExist.aspx?thcno=" + THCNo + "&sid=" + Math.random();
                     findobj.open("GET",strpg,true);
                     findobj.onreadystatechange=function()
                         {
                          
                             if(findobj.readyState==4 && findobj.status==200)
                                {
                                    var res=findobj.responseText.split("|");
                                    if(res[0]=="false")
                                    {
                                        alert("THC NO is not Valid... Please Enter Valid THC No");
                                        txtTHCNo.value="";
                                        txtTHCNo.focus();
                                        return false;
                                    }
                                    if(res[0]=="true")
                                    {
                                    //debugger
                                        var thc_Date= document.getElementById("ctl00_MyCPH1_hidDate").value;
	                                    document.getElementById(thc_Date).value = res[1];
	                                    var thc_From= document.getElementById("ctl00_MyCPH1_hidFrom").value;
	                                    document.getElementById(thc_From).value = res[2];
	                                    var thc_To= document.getElementById("ctl00_MyCPH1_hidTo").value;
	                                    document.getElementById(thc_To).value = res[3];
	                                    var thc_manualNo1= document.getElementById("ctl00_MyCPH1_hidManualNo").value;
	                                    document.getElementById(thc_manualNo1).value = res[4];
                                        return false;
                                    }
                                    
                                }
                         }
                         
                    findobj.send(null);
                    }
                return false;
             }
                function CheckData()
                {
                    //debugger
                    var grid=document.getElementById("ctl00_MyCPH1_grvcontrols");
                    var rows=grid.rows.length;
                    var i = 2,x = 0;
                    var thcno;
                    var ChkSel;
                       for(i = 2; i < rows ; i++)
                       {
                        if(i<10)
                        {
                           thcno=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtTHCNo").value;
                           ChkSel=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_ChkSel").checked;
                        }
                        else
                        {
                           thcno=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtTHCNo").value;
                           ChkSel=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_ChkSel").checked;
                         }
                         if(ChkSel == true)
                         {
                            x = 1;
                            if(thcno == '')
                            {
                                alert("Please Enter the THC Number");
                                return false;
                            }
                            
                         }
                    }
//                    if(x == 0)
//                     {
//                          alert("Please Select atleast one Row !!");
//                          return false;
//                      }
                    //return false;
                } 


    </script>

    <div style="width: 10in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" style="border-right: 0px; border-top: 0px;
                border-left: 0px; border-bottom: 0px" />
        </a>
    </div>
    <div style="width: 10in; text-align: center">
        <table cellspacing="1" class="boxbg" style="width: 10in; text-align: center">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>THC Details</strong>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080"
                    width="50%">
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt" width="50%">
                            Enter No. of Rows</td>
                        <td align="left" class="blackfnt" width="50%">
                            <asp:TextBox ID="txtnorows" runat="server">5</asp:TextBox>
                            <asp:Button ID="btnrows" runat="server" OnClick="btnrows_Click" Text="Add Rows" />
                        </td>
                    </tr>
                </table>
                <br />
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080;
                    text-align: center" width="100%">
                    <tr class="bgbluegrey">
                        <td align="center" class="blackfnt">
                            THC Detail</td>
                    </tr>
                    <tr style="background-color: #ffffff;">
                        <td align="Center" class="blackfnt">
                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                OnRowDataBound="grvcontrols_RowDataBound" PagerSettings-FirstPageText="[First]"
                                PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left"
                                Width="60%">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="White" />
                                        <HeaderStyle CssClass="blackfnt" BackColor="#D4E0E7" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="ChkSel" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="THC No">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="txtTHCNo" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                                Enabled="true" MaxLength="50" Width="100px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manual THC No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblManualTHCNo" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="THC Date">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblTHCDate" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblFrom" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="To">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblTo" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Left" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td class="blackfnt" style="text-align: center">
                            <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" OnClientClick="javascript:return CheckData();"
                                Text="Submit" />
                                <asp:HiddenField ID="hidFrom" runat="server" />
                                <asp:HiddenField ID="hidTo" runat="server" />
                                <asp:HiddenField ID="hidDate" runat="server" />
                                <asp:HiddenField ID="hidManualNo" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
