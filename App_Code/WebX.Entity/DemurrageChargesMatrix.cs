using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DemurrageChargesMatrix
/// </summary>
public class DemurrageChargesMatrix
{
    private string m_ContractId;
    private string m_FromLocation;
    private string m_ToLocation;
    private string m_TransMode;
    private string m_BusinessType;
    private string m_ProductType;
    private string m_DemurrageCalculationBasis;
    private string m_RateType;
    private int m_FreeStorageDay;
    private string m_EntryBy;
    private string m_MatrixType;
	public DemurrageChargesMatrix()
	{
        m_ContractId = string.Empty;
        m_FromLocation = string.Empty;
        m_ToLocation = string.Empty;
        m_TransMode = string.Empty;
        m_BusinessType = string.Empty;
        m_ProductType = string.Empty;
        m_DemurrageCalculationBasis = string.Empty;
        m_RateType = string.Empty;
        m_EntryBy = string.Empty;
        m_MatrixType = string.Empty;
        m_FreeStorageDay = 0;
	}
    // ContractId
    public string ContractId
    {
        get
        {
            return m_ContractId;
        }
        set
        {
            m_ContractId = value;
        }
    }

    // FromLocation
    public string FromLocation
    {
        get
        {
            return m_FromLocation;
        }
        set
        {
            m_FromLocation = value;
        }
    }

    // ToLocation
    public string ToLocation
    {
        get
        {
            return m_ToLocation;
        }
        set
        {
            m_ToLocation = value;
        }
    }

    // TransMode
    public string TransMode
    {
        get
        {
            return m_TransMode;
        }
        set
        {
            m_TransMode = value;
        }
    }

    // BusinessType
    public string BusinessType
    {
        get
        {
            return m_BusinessType;
        }
        set
        {
            m_BusinessType = value;
        }
    }

    // ProductType
    public string ProductType
    {
        get
        {
            return m_ProductType;
        }
        set
        {
            m_ProductType = value;
        }
    }

    // DemurrageCalculationBasis
    public string DemurrageCalculationBasis
    {
        get
        {
            return m_DemurrageCalculationBasis;
        }
        set
        {
            m_DemurrageCalculationBasis = value;
        }
    }

    // RateType
    public string RateType
    {
        get
        {
            return m_RateType;
        }
        set
        {
            m_RateType = value;
        }
    }

    // EntryBy
    public string EntryBy
    {
        get
        {
            return m_EntryBy;
        }
        set
        {
            m_EntryBy = value;
        }
    }

    // MatrixType
    public string MatrixType
    {
        get
        {
            return m_MatrixType;
        }
        set
        {
            m_MatrixType = value;
        }
    }

    // FreeStorageDay
    public int FreeStorageDay
    {
        get
        {
            return m_FreeStorageDay;
        }
        set
        {
            m_FreeStorageDay = value;
        }
    }
    List<DemurrageChargesMatrixSlab> listDetails = new List<DemurrageChargesMatrixSlab>();
    public List<DemurrageChargesMatrixSlab> ListDetails { get { return listDetails; } set { listDetails = value; } }

}
[Serializable]
public class DemurrageChargesMatrixSlab
{
    private int m_FromSlab;
    private int m_ToSlab;
    private double m_Rate;
    private string m_SlabCode;
    public DemurrageChargesMatrixSlab()
	{
        m_FromSlab = 0;
        m_ToSlab = 0;
        m_Rate = 0;
        m_SlabCode = string.Empty;
	}
    // FromSlab
    public int FromSlab
    {
        get
        {
            return m_FromSlab;
        }
        set
        {
            m_FromSlab = value;
        }
    }

    // ToSlab
    public int ToSlab
    {
        get
        {
            return m_ToSlab;
        }
        set
        {
            m_ToSlab = value;
        }
    }

    // Rate
    public double Rate
    {
        get
        {
            return m_Rate;
        }
        set
        {
            m_Rate = value;
        }
    }

    // SlabCode
    public string  SlabCode
    {
        get
        {
            return m_SlabCode;
        }
        set
        {
            m_SlabCode = value;
        }
    }


}