<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MultipleSlabSundryFreightMatrix.aspx.cs" Inherits="GUI_AllTest_MultipleSlabSundryFreightMatrix"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
   
    
    
function windowPopUp(mode,ctlid,tbl)
{
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
    confirmWin=window.open(url,"",winOpts);
    return false;
}

    
function windowHeadPopUp(mode,ctlid,tbl,head)
{
     var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=" + head ;
            confirmWin=window.open(url,"",winOpts);
            return false;
}

function locTest(txtid,testtype)
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    var txt=document.getElementById(txtid);
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }
   
    txt.value=txt.value.toUpperCase();
    var strpg="";
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
         if(testtype=="citytest")
            strpg="AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
         else if(testtype=="loctest")
             strpg="AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
         else if(testtype=="zonetest")
             strpg="AjaxResponse.aspx?mode=check&code1=zonetest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                      var res=findobj.responseText.split("|");
                      if(res[0]=="false")
                         {
                            if(testtype=="citytest")
                                alert("City doesn't Exists...");
                            else if(testtype=="loctest")
                                alert("Location doesn't Exists...");
                            else if(testtype=="zonetest")
                                alert("Region doesn't Exists...");
                            txt.value="";
                            txt.focus();
                            hdnajaxstate.value="0";
                            return false;
                         }
                      else if(res[0]=="true")
                      {
                            hdnajaxstate.value="0";
                      }
                }
         }
         
    findobj.send(null);
    }

   return true;
}
    
     function submitValidation()
     {
     
        var hdnajaxstate =  document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        var grid =  document.getElementById("ctl00_MyCPH1_grvcharges");
        var len=parseInt(grid.rows.length);
        var pref="";
        var cnt=0;
        for(var i=2;i<=len;i++)
        {
            if(i<10)
                pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
            else
                pref = "ctl00_MyCPH1_grvcharges_ctl"+ i + "_";
            
            var txtfrom = document.getElementById(pref+"txtfrom");
            var txtto = document.getElementById(pref+"txtto");
            var chkyes = document.getElementById(pref+"chkyes");
            
            if(chkyes.checked==true)
            {
            cnt++;
                if(txtfrom.value=="")
                {
                    alert("Please Enter From Location");
                    txtfrom.focus();
                    return false;
                }
                
                if(txtto.value=="")
                {
                    alert("Please Enter To Location");
                    txtto.focus();
                    return false;
                }
                
                for(var j=2;j<len;j++)
                {
                    var jref="";
                    if(j<10)
                        jref = "ctl00_MyCPH1_grvcharges_ctl0" + j + "_";
                    else
                        jref = "ctl00_MyCPH1_grvcharges_ctl"+ j + "_";
                    
                    var txtjfrom = document.getElementById(jref+"txtfrom");
                    var txtjto = document.getElementById(jref+"txtto");
                    
                    if(i!=j)
                    {
                        if(txtjfrom.value=="")
                        {
                            alert("Please Enter From Location");
                            txtjfrom.focus();
                            return false;
                        }
                        
                        if(txtjto.value=="")
                        {
                            alert("Please Enter To Location");
                            txtto.focus();
                            return false;
                        }
                        
                        if(txtfrom.value==txtjfrom.value && txtto.value==txtjto.value)
                        {
                            alert("No Two  pair should be same.Please Enter Another Location");
                            txtto.value="";
                            txtto.focus();
                            return false;
                        }
                        
                    } // i!=j
                    
                } //  J loop
            
            } // Check of YES/NO        

        } // I loop
        
        if(cnt==0)
        {
            if(!confirm("No Record Selected. All listed data will be removed.Do you want to continue ?"))
                return false;
        }
        return true;
    }
    </script>
    <cust:CustInfo runat="server" ID="cstheader" />
    <asp:UpdatePanel ID="upone" runat="server">
        <ContentTemplate>
            <asp:UpdatePanel runat="server" ID="updone">
                <ContentTemplate>
                    <asp:Table ID="Table1" runat="server">
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell ColumnSpan="2" CssClass="blackfnt">
                            Please Note : &nbsp;<font class='redfnt'>Existing Data will be Replaced, if any</font>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell ColumnSpan="2" CssClass="blackfnt">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="Table3" HorizontalAlign="Left" runat="server" CellSpacing="1" CssClass="boxbg"
                                    Width="5in">
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">Matrix Type
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblmatrixtype" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">Trans Mode
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lbltransmode" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbasedon1" runat="server" CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasedon1" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasecode1" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbasedon2" runat="server" CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasedon2" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasecode2" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">From Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterfrom" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">To Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterto" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <br />
                                <br />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="tblmain" CellSpacing="1" CssClass="boxbg" runat="server">
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Label ID="lblheader" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Sundry Multiple Slab Rates"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="20%">Enter No of Rows
                                        </asp:TableCell>
                                        <asp:TableCell Width="80%">
                                            <asp:TextBox ID="txtrows" Width="40px" Style="text-align: right;" onkeypress="javascript:return validInt(event)"
                                                BorderStyle="Groove" MaxLength="2" CssClass="blackfnt" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnaddrows" runat="server" OnClick="btnaddrows_Click" CssClass="blackfnt"
                                                Text="Add New Rows" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                                CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                                HeaderStyle-CssClass="bgbluegrey" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..."
                                                OnRowDataBound="grvcharges_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkyes" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <HeaderTemplate>
                                                            From
                                                            <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtfrom" Width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"fromloc") %>'
                                                                            BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <HeaderTemplate>
                                                            To
                                                            <input type="button" id="btnto" runat="server" class="blackfnt" value="...." />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtto" Width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"toloc") %>'
                                                                            BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnto" runat="server" onclick="return false;" class="blackfnt"
                                                                            value="...." />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Transit Days" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays" runat="server" MaxLength="3" CssClass="blackfnt" Width="70px" onkeypress="javascript:return validInt(event)"
                                                               Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' style="text-align:right;" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Slab 1" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtslab1" runat="server" CssClass="blackfnt" Width="70px" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                              Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' style="text-align:right;" MaxLength="8" onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Slab 2" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtslab2" runat="server" CssClass="blackfnt" Width="70px" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                              Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' style="text-align:right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Slab 3" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtslab3" runat="server" CssClass="blackfnt" Width="70px" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                              Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' style="text-align:right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Slab 4" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtslab4" runat="server" CssClass="blackfnt" Width="70px" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                               Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>'  style="text-align:right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Slab 5" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtslab5" runat="server" CssClass="blackfnt" Width="70px" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                               Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>'  style="text-align:right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Slab 6" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtslab6" runat="server" CssClass="blackfnt" Width="70px" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                               Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  style="text-align:right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" BorderStyle="Groove">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" OnClick="btnsubmit_Click"
                                                OnClientClick="javascript:return submitValidation()" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:HiddenField ID="hdncontractid" runat="server" />
                    <asp:HiddenField ID="hdncontracttype" runat="server" />
                    <asp:HiddenField ID="hdncustcode" runat="server" />
                    <asp:HiddenField ID="hdnbasedon1" runat="server" />
                    <asp:HiddenField ID="hdnbasecode1" runat="server" />
                    <asp:HiddenField ID="hdnbasedon2" runat="server" />
                    <asp:HiddenField ID="hdnbasecode2" runat="server" />
                    <asp:HiddenField ID="hdnmatrixtype" runat="server" />
                    <asp:HiddenField ID="hdntransmode" runat="server" />
                    <asp:HiddenField ID="hdntransname" runat="server" />
                    <asp:HiddenField ID="hdnajaxstate" runat="server" />
                    <asp:HiddenField ID="hdnfrom" runat="server" />
                    <asp:HiddenField ID="hdnto" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
