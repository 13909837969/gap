<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>社区矫正工作监管</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JzJzryJzlxxService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		#sqjz_formJzryTjfx_all{
			/* 此处设置整体宽度
				若该宽度小于table宽度，则表会挤在一起
				若该宽度远远大于table宽度，则表右侧空白区域会增大
			 */
			/* width:100%; */
		}
		table{
			border-width: 1px;
			border-collapse:collapse;
			text-align:center;
			padding:10px;
		}
		table td{
			border-style: solid;
			border-width: 1px;
			font-size:15px;
		}
		table td div{
			margin:0 3px;
			
		}
		th{
			font-size:28px;
			text-align:center;
			margin:0 auto;
		}
		#sqjz_formJzryTjfx_all #first_row{
			width:100px;
		}
		#sqjz_formJzryTjfx_all #dw td{
			width:10px;
		}
	</style>
</head>
<body>
	<div id="sqjz_formJzryTjfx_all">
		<table>
			<thead>
				<tr>
					<th colspan="34">社 区 矫 正 工 作 监 管</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="5" id="first_row">地区\项目</td>
					<td rowspan="3">在册<br>社区<br>矫正<br>人数</td>
					<td rowspan="3">矫正小组</td>
					<td colspan="4">管理等级</td>
					<td colspan="3">监督管理</td>
					<td colspan="4">教育矫正</td>
					<td colspan="5">帮困扶助</td>
					<td colspan="5">奖惩情况</td>
					<td colspan="3">适用社区影响评估	</td>
					<td colspan="7">基础工作建设	</td>
				</tr>
				<tr>
					<td rowspan="2"><div>初期矫正</div></td>
					<td rowspan="2"><div>宽松管理</div></td>
					<td rowspan="2"><div>普通管理</div></td>
					<td rowspan="2"><div>严格管理</div></td>
					<td rowspan="2"><div>报到违规</div></td>
					<td rowspan="2"><div>脱管情况</div></td>
					<td rowspan="2"><div>执行中止</div></td>
					<td rowspan="2"><div>组织集中教育</div></td>
					<td rowspan="2"><div>个别谈话教育</div></td>
					<td rowspan="2"><div>进行心理辅导</div></td>
					<td rowspan="2"><div>组织社区服务</div></td>
					<td rowspan="2"><div>落实低保</div></td>
					<td rowspan="2"><div>落实承包田</div></td>
					<td rowspan="2"><div>技能培训</div></td>
					<td rowspan="2"><div>指导就业或就学</div></td>
					<td rowspan="2"><div>其他</div></td>
					<td rowspan="2"><div>减刑</div></td>
					<td rowspan="2"><div>警告</div></td>
					<td rowspan="2"><div>治安处罚</div></td>
					<td rowspan="2"><div>收监执行</div></td>
					<td rowspan="2"><div>再犯罪</div></td>
					<td rowspan="2"><div>接受委托</div></td>
					<td rowspan="2"><div>完成评估</div></td>
					<td rowspan="2"><div>采信</div></td>
					<td colspan="3"><div>队伍建设</div></td>
					<td colspan="4"><div>基地建设</div></td>
				</tr>
				<tr>
					<td><div>专职工作人员</div></td>
					<td><div>专职社会工作者</div></td>
					<td><div>社会志愿者</div></td>
					<td><div>已建立就业基地</div></td>
					<td><div>已建立教育基地</div></td>
					<td><div>已建立社区服务基地</div></td>
					<td><div>已建立社区矫正中心</div></td>
				</tr>
				<tr id="dw">
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人次</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>件</td>
					<td>件</td>
					<td>件</td>
					<td>人</td>
					<td>人</td>
					<td>人</td>
					<td>个</td>
					<td>个</td>
					<td>个</td>
					<td>个</td>
				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>呼和浩特市</td>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>包头市</td>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>呼伦贝尔市</td>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>兴安盟</td>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>通辽市</td>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>赤峰市</td>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
				</tr>
				<tr>
					<td>锡林郭勒盟</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
				<tr>
					<td>乌兰察布市</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
				<tr>
					<td>鄂尔多斯市</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
				<tr>
					<td>巴彦淖尔市</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
				<tr>
					<td>乌海市</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
				<tr>
					<td>阿拉善盟</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
				<tr>
					<td>合计</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
					<td>24</td>
					<td>25</td>
					<td>26</td>
					<td>27</td>
					<td>28</td>
					<td>29</td>
					<td>30</td>
					<td>31</td>
					<td>32</td>
					<td>33</td>
					<td>34</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>