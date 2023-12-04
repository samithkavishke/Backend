import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient({log:["query"]})

async function main() {
    const name = 'samith'
    const user = await prisma.user.create({data:{username:"sachini",type:"PHARMACIST",email_address:"sthanushka@gmail.com",hash:"$2a$12$e7NWSyBrjhb73QkPDcXC5uAw7coyajuPW/cXeAtuzma7.MuQNGbQ2"}})
    // const user = await prisma.user.update({
    //   where: {
    //     email_address:'samithkarunathilake@gmail.com'
    //   },
    //   data: {
    //     type: "ADMIN"
    //   }
    // })
    console.log(user)
}

main()
.catch(e=>{
    console.error(e.message)
})
.finally(async () =>{
    await prisma.$disconnect()
})