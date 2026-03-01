package model;

public class Employee {
    private int empId;
    private String empName;
    private int deptId;
    private double salary;

    public Employee() {}

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public String getEmpName() { return empName; }
    public void setEmpName(String empName) { this.empName = empName; }

    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }

    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }
}
