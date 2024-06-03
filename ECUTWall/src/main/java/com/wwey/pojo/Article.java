package com.wwey.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.wwey.anno.State;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.groups.Default;
import lombok.Data;
import org.hibernate.validator.constraints.URL;

import java.time.LocalDateTime;

@Data
public class Article {

    @NotNull(groups = update.class)
    private Integer id;
    @NotEmpty
    @Pattern(regexp = "^\\S{1,25}$")
    private String title;
    @NotEmpty
    private String content;
    @NotEmpty
    @URL
    private String coverImg;
    @State
    private String state;
    @NotNull
    private Integer categoryId;
    @JsonIgnore
    private Integer createUser;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public interface add extends Default {

    }

    public interface update extends Default{

    }

}
