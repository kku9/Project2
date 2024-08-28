<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&family=Gowun+Dodum&family=Jua&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/7395e48b31.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
    <script src="./js/main.js" defer></script>
    <title>게시판 - 놀러가자</title>
    <style>
        h1 {
            margin-bottom: 100px; /* 제목과 표 사이의 간격 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px; /* 표와 게시판 제목 사이의 간격 추가 */
            margin-bottom: 300px; /* 표와 푸터 사이의 간격 추가 */
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* 후기 셀 스타일 */
        .review-cell {
            position: relative;
        }

        /* 후기 내용에 마우스를 올리면 버튼이 나타남 */
        .review-cell button {
            display: none;
            position: absolute;
            bottom: 5px;
            right: 5px;
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .review-cell:hover button {
            display: inline-block;
        }
    </style>
</head>
<body>

    <!-- navbar -->
    <nav id="navbar">
        <div class="navbar_logo">
            <a href="index.jsp"><i class="fas fa-star"></i> 놀러가자</a>
        </div>
        <ul class="navbar_list">
            <li class="space-before"><a href="product-search.jsp">인기숙소</a></li>
            <li><a href="lend.jsp">국내숙소</a></li>
            <li><a href="docs-search.jsp">게시판</a></li>
            <li><a href="docs-register.jsp">리뷰등록</a></li>
            <li><a href="introduce.jsp">회사소개</a></li>
        </ul>
        <ul class="navbar_list">
            <li><a href="login.jsp">로그인</a></li>
            <li><a href="signup.jsp">회원가입</a></li>
        </ul>
        <button class="navbar_toggle_btn">
            <i class="fas fa-bars"></i>
        </button>
    </nav>

    <section class="section">
        <div class="section_container">
            <h1>게시판</h1>
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>숙소명</th>
                        <th>별점</th>
                        <th>후기</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                     // 데이터베이스 연결 정보
                        String jdbcUrl = "jdbc:mariadb://trd-prd-rds-master.crgoyc04k2rj.ap-northeast-2.rds.amazonaws.com:3306/nolgaja_db";
                        String dbUser = "boss";
                        String dbPassword = "sd12!fg34";

                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        int rowNumber = 1; // 번호를 순서대로 매기기 위한 변수
                    %>
                    <%
                        try {
                            Class.forName("org.mariadb.jdbc.Driver");
                            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                            String sql = "SELECT accommodation_name, rating, review_content, created_at FROM reviews ORDER BY review_id DESC";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while(rs.next()) {
                                String accommodationName = rs.getString("accommodation_name");
                                int rating = rs.getInt("rating");
                                String reviewContent = rs.getString("review_content");
                                Timestamp createdAt = rs.getTimestamp("created_at");
                    %>
                    <tr>
                        <td><%= rowNumber++ %></td> <!-- 번호를 1씩 증가 -->
                        <td><%= accommodationName %></td>
                        <td><%= rating %></td>
                        <td class="review-cell">
                            <%= reviewContent %>
                            <button onclick="alert('후기 내용을 클릭했습니다!')">클릭</button>
                        </td>
                        <td><%= createdAt %></td>
                    </tr>
                    <%
                            }
                        } catch(Exception e) {
                            e.printStackTrace();
                        } finally {
                            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
                            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
                            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </section>

    <!-- footer -->
    <footer id="footer">
        <div class="footer_logo">
            <div class="navbar_logo">
                <i class="fas fa-star"></i>
                <a href="index.jsp">놀러가자</a>
            </div>
        </div>
        <div class="footer_text">
            <p class="footer_text_p">한국정보교육원 | 서울시 관악구 봉천로 227 보라매샤르망 503호</p>
            <p class="footer_text_p">TEL : 010-0000-0000 / E-MAIL : phyeonw95@gmail.com</p>
            <p class="footer_text_p">COPYRIGHT (C)2024 놀러가자. ALL RIGHTS RESERVED.</p>
        </div>
        <div class="footer_box">
            <ul class="footer_list">
                <li><a href="introduce.jsp" class="footer_text_p">회사소개</a></li>
                <li><a href="conditions.jsp" class="footer_text_p">이용약관</a></li>
                <li><a href="user-policy.jsp" class="footer_text_p">개인정보처리방침</a></li>
                <li><a href="instruction.jsp" class="footer_text_p">서비스이용안내</a></li>
            </ul>
        </div>
    </footer>

</body>
</html>
