package data.spring.automappingobjects.models.DTOs;

import java.util.List;

public class ManagerDTO extends BasicEmployeeDTO {

    private List<EmployeeDTO> subordinates;


    public List<EmployeeDTO> getSubordinates() {
        return subordinates;
    }

    public void setSubordinates(List<EmployeeDTO> subordinates) {
        this.subordinates = subordinates;
    }
}
