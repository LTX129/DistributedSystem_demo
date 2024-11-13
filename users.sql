create table users
(
    id             int auto_increment
        primary key,
    username       varchar(50)                    not null,
    password       varchar(100)                   null,
    email          varchar(100)                   null,
    role           varchar(10) default 'customer' null,
    encrypted_data text                           null
);

INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (1, 'LiTongxuan', '$2a$10$N8A0YHT.sg99/IHubV4Xlux4M2XRIu3.J6VzASeZfWYZkBWBckXmC', '21722052@bjtu.edu.cn', 'customer', 'yoohQF0qDL2r9PnM5wF9QmElsE68AbXCF6/BtbjP2f9KdZ8C36GfKIHp2hGn94p3r8nOvFcPWfaQ3KoyfiVzo2MLc257eTUP+2GntNQAhl7liNoHn6QgntbB+8y8P05dBX0JasChXt95WU0Yxq7HHD0JnyzONwxutUicppFF82S9lCmdV9+4jFXu2m3LOWGCDFGvfWBNz1AAjsy5UP5BM/6ZJ0mxVHGDqpoO+TYrOeA3pSXsPdyV5qjsy9F1Vml4ITNuyhNLccTwMaSJZ6qlRcGf8dyQGEaiX5xLZAWKNcvtXVafycpEUMtBmf4Wu2TLroFMKAcr0KGqsBEdbUWa6w==');
INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (2, 'leizimo', '$2a$10$kQrYPo/0MjmnjDzVLxBoyORlKSohmQrBaD.PuhQAcEe4yfNZ0sQli', '21722051@bjtu.edu.cn', 'customer', 'uyQzFzemXpr4DYdeYqX3daz88bauncQ2mweNHEr5PDfFLJB7QIcH7IIpoNvDqZItvoj9OJvpfS3aY4h0+69VWnVPQ+DJYqS53gfviyhpaWYlGIWe5TFgBdEOATVHBYeDuT5/PJrY5mRXflCnQzPPKPPAVOx9vkS6EVTf/6vtL8Se8tVOP/j/1dSToLzyGH52pGb4PlayoXJB2mEs0OTK+uUtceXoapxkjYwlnpaDkwchq6JzDBzedSBMqx3H5FadGaW3DDnbTY4YEzFHmjjkCGd2DUuYTj7FVnHBfKd1objuCWwG/n2KkcxQUnyi7mT6ikdRw4TMR9s0Ql3SB+8DyA==');
INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (3, 'ShiShang', '$2a$10$IUZ/G0YN8Y5gi4iNc6/lS.XO3tyBVjgmzV6nNScMif7W0hFqvtT2O', '21722059@bjtu.edu.cn', 'customer', 'o0aPJY8d8UCCL1JG4zZPvFU4jVHzElR2mNNivjhkyofkqQqTovSpp9oG29p+Ql2oIrKskG1ucgJghbq3AzGRjppM5si3bXSpw3CkbOKqrPpviS/aD3KkEQ6drb7X5f1LDdVnsD03F15ScipWy1LVKftHIz8yh8bezpWg9avWxo3/FM7JPVJQoQHAH4W3pmFLN13+Vb4mqLuverks+AP8Nv2eiROqEIpP6HhTQORSsLJ9XzRvVeAONvCal5zwFNZ3dh9zfOYfaSmEa4PYC/Zg4CNf83WPTNOPcWuBvLyI5r/YHxzNpgfOyuIxpnBXJqKWJZk0OrloU126ZZbGKCquNg==');
INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (4, 'ChenGuo', '$2a$10$0tOhrKzSnBFcRi6zaLuApu/a1K8ZPz8AWMBe3zvMnaZp1kyaCESGq', '21722042@bjtu.edu.cn', 'customer', 'zzAYV0rqpkPETBgCgX+z4yE0/bC+mGZxGA/tgyCwqH92GfVYUftEyA81E/5FbihsGLJpPW6hjLENt3myueTMGHvks/cn8tBf789es/FFn1xLzoe0W9XJurn0Se0X7QSEeM5bsrjriCv0EQuMs2pL7lZpjdN3vKDF899eP8YZsGyjZFUBCM5OcZQfA0X+FvMIiypf7L79biphy0BBGrFQO41i1QFAFEZtFlKAN/BdzdPynyoMOXkPJFLWVWy7H6d9fu1hOxg5k3reAfcCl+L8MlMhFLAbAWkaK2Tc+1pfCWlYXtNX0MVyFyKc8LNNQUcX6YV3tSYRIzprySrH6mGVxA==');
INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (5, 'zhangliuxiang', '$2a$10$J6ct3ofK7NEgBu0KlS0Mv.DBclcbHqGVi0VIobUjqqloF8pTPxKxO', '21722075@bjtu.edu.cn', 'customer', 'bLLy6dnL+/3YXy8W5Rx4jvJjcOOH1FN2aTt5Y1KCImryImeAPTsbRcb/tvy95p9ENuBHFGxrk+53hwNaZdBpeRMUF8dgpEVnM07ddn6ByjpY7HQG8YawPD3wg0LlzUCmad6onqsAMXMpLgqcn4PZi/P+nB07kllprlnXNWZdxSYpQCj0FWCMcQrjPXxI6WK6vPusaZ1xvH+HrraAzW3qQK+8fHGaCrxkZ6CfWUIbWVfx1AjiyBU1Wlwf9m4cKJPIMwxeK1vxmYotiiqbvr/tZmMKNRYhjku+geQ3L6wPfJfHGZME3lSo4bgQX0csXLrzAur8LVTFuPlOrT1PEKIa4Q==');
