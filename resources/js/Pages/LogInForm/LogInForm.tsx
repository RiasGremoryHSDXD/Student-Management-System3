import { useState } from 'react'
import '../../../css/LogInForm/LogInForm.css'

export default function LogInForm(){
    
    const [userEmail, setUserEmail] = useState<string>("")
    const [userPassword, setUserPassword] = useState<string>("")
    const [isEmailValid, setIsEmailValid] = useState<boolean>(true);
    const [isPasswordValid, setIsPasswordValid] = useState<boolean>(true);


    function credentialsAuthentication(email: string, password: string): boolean {
        return email === "1" && password === "1"
    }

    function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
        e.preventDefault()
        const valid = credentialsAuthentication(userEmail, userPassword)
        setIsEmailValid(valid)
        setIsPasswordValid(valid)
    }

    return(
        <div className='log-in-form-container'>
            <form action="" onSubmit={handleSubmit}>
                <input
                    className={`border ${isEmailValid ? 'border-gray-500' : 'border-red-500'}`}
                    type="text"
                    value={userEmail}
                    onChange={(e) => setUserEmail(e.target.value)}
                    placeholder='Email' 
                />
                {!isEmailValid && <p>Invalid email</p>}
                <input
                    className={`border ${isPasswordValid ? 'border-gray-500' : 'border-red-500'}`}
                    type="text"
                    value={userPassword}
                    onChange={(e) => setUserPassword(e.target.value)}
                    placeholder='Password'
                />
                {!isPasswordValid && <p>Invalid password</p>}
                <button type='submit'>
                    <p>Log In</p>
                </button>
            </form>
        </div>
    )
}