package ${packagename};

import com.ehtsoft.fw.core.dto.Basic;
/**
 * ${tableConfig.label!}
 * <br>${tableConfig.remark!}
 * @author wangbao
 */
public class ${tableConfig.name!} extends Basic {
  <#list tableConfig.columns as col>
    /**
     * ${col.label!}
     * <br>${col.remark!}
     */
    private ${col.getTypeOfJava()} ${col.property};
  </#list>
  <#list tableConfig.columns as col>
    /**
     * ${col.label!}
     * <br>${col.remark!}
     */
    public ${col.getTypeOfJava()} get${col.property?cap_first}() {
        return ${col.property};
    }
    /**
     * ${col.label!}
     * <br>${col.remark!}
     */
    public void set${col.property?cap_first}(${col.getTypeOfJava()} ${col.property}) {
        this.${col.property} = ${col.property};
    }
  </#list>
}
